from __future__ import absolute_import
from __future__ import print_function
import model_set
from model_set import CNN, LSTMRNN, kerasLSTM
import numpy as np
from keras.models import Model, Sequential
from keras.layers import Input, Flatten, Dense, Dropout, Lambda, Conv2D, MaxPooling2D, Concatenate, TimeDistributed
from keras.layers import GRU, LSTM, SimpleRNN, Bidirectional
from keras import backend as K
from keras.optimizers import SGD, RMSprop
import re
import os.path
import pandas as pd
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt  
from keras.models import load_model


BATCH_START = 0

BATCH_SIZE = 1
INPUT_SIZE = 1
OUTPUT_SIZE = 1
CELL_SIZE = 10
LR = 0.006  


# EPOCH = 50
EPOCHS = 10
BATCH_SIZES = 30
LEN_VEL = 350
TIME_STEPS = LEN_VEL

def load_imdata(input_file):
    '''
    读取图片数据，返回训练及测试的特征矩阵和标签向量
    '''
    image_datas = []
    X_img = []
    pathDir_1 =  os.listdir(input_file)
    for allDir_1 in pathDir_1:
        child = os.path.join('{0}\{1}'.format(input_file, allDir_1))
        df=pd.read_csv(child)
        image_datas.append(df)
    for data in image_datas:
        # print(data.shape)
        x = data.values.reshape(data.shape[0], data.shape[1], 1).astype('float32') / 255.
        X_img.append(x)
    print(len(X_img))
    # X_img = np.array(X_img)
    # return X_img
    x_imgX_imgdata = X_img
    split_num = int(len(x_imgX_imgdata)-len(x_imgX_imgdata)/8)
    train_metadata = x_imgX_imgdata[0]
    x_imgX_imgdata = np.array(x_imgX_imgdata)
    
    return x_imgX_imgdata

def load_sf(input_file):
    df_xset = []
    df_yset = []
    df_aset = []
    pathDir_1 =  os.listdir(input_file)
    for allDir_1 in pathDir_1:
        child = os.path.join('{0}\{1}'.format(input_file, allDir_1))
        df=pd.read_csv(child, header=None)
        df_sx = df.loc[0,0]
        df_sy = df.loc[0,1]
        df_sa = df.loc[0,2]
        df_fx = df.loc[0,6]
        df_fy = df.loc[0,7]
        df_fa = df.loc[0,8]
        df_x = np.zeros(([100]))
        df_x[0] = df_sx
        df_x[99] = df_fx
        df_y = np.zeros(([100]))
        df_y[0] = df_sy
        df_y[99] = df_fy
        df_a = np.zeros(([100]))
        df_a[0] = df_sa
        df_a[99] = df_fa
        df_xset.append(df_x)
        df_yset.append(df_y)
        df_aset.append(df_a)
    coord_marix = np.array([df_xset,df_yset,df_aset])
    print(coord_marix.shape)
    coord_marix = coord_marix.reshape(coord_marix.shape[1],
                                      coord_marix.shape[0],
                                      coord_marix.shape[2],
                                      1
                                      )
    return coord_marix


def get_rnndata():
    global BATCH_START, TIME_STEPS
    trdata_seq = []
    trdata_res = []
    trdata_xs = []
    mul_fun_data = []
    for i in range(500):  
        # xs shape (50batch, 20steps)    
        # 创建等差数列
        xs = np.arange(BATCH_START, BATCH_START+TIME_STEPS*BATCH_SIZE).reshape((BATCH_SIZE, TIME_STEPS))  / 10    #(10*np.pi)    
        print(xs[0])
        print(xs.shape)
        seq = np.sin(xs)    
        res = np.cos(xs)    
        mul_fun = [seq, res]
        BATCH_START += 1    
        # plt.plot(xs[0, :], res[0, :], 'r', xs[0, :], seq[0, :], 'b--')    
        # plt.show()    
        # returned seq, res and xs: shape (batch, step, input)    
        seq = seq[:, :, np.newaxis]
        res = res[:, :, np.newaxis]
        trdata_seq.append(seq)
        trdata_res.append(res)
        trdata_xs.append(xs)
    trdata_seq = np.array(trdata_seq)
    trdata_res = np.array(trdata_res)
    trdata_xs = np.array(trdata_xs)
    print(trdata_seq.shape)
    print(trdata_res.shape)
    print(trdata_xs.shape)
    return [trdata_seq, trdata_res, trdata_xs]  # 给原数组增加一个维度

def get_vel(input_file):
    vel_X = []
    vel_Y = []
    vel_A = []
    pathDir_1 =  os.listdir(input_file)
    for allDir_1 in pathDir_1:
        child = os.path.join('{0}\{1}'.format(input_file, allDir_1))
        print(child)
        df=pd.read_csv(child, header=None)
        dfx = df.loc[:,0]
        dfx = np.array(dfx)
        dfx = dfx.reshape(len(dfx), 1)
        # print(len(dfx), dfx.shape)
        if len(dfx) <= LEN_VEL:
            x_dimnum = LEN_VEL-len(dfx)
            x_dim = np.zeros((x_dimnum,1))
            dfx = np.row_stack((dfx, x_dim))
            # print(len(dfx), dfx.shape)
        else:
            dfx = dfx[:LEN_VEL]
        vel_X.append(dfx)

        dfy = df.loc[:,1]
        dfy = np.array(dfy)
        dfy = dfy.reshape(len(dfy), 1)
        if len(dfy) <= LEN_VEL:
            # print(len(dfy), dfy.shape)
            y_dimnum = LEN_VEL-len(dfy)
            y_dim = np.zeros((y_dimnum,1))
            dfy = np.row_stack((dfy, y_dim))
        else:
            dfy = dfy[:LEN_VEL] 
        # print(len(dfy), dfy.shape)
        vel_Y.append(dfy)

        dfa = df.loc[:,2]
        dfa = np.array(dfa)
        dfa = dfa.reshape(len(dfa), 1)
        # print(len(dfa), dfa.shape)
        if len(dfa) <= LEN_VEL:
            a_dimnum = LEN_VEL-len(dfa)
            a_dim = np.zeros((a_dimnum,1))
            dfa = np.row_stack((dfa, a_dim))
            # print(len(dfa), dfa.shape)
        else:
            dfa = dfa[:LEN_VEL]
        vel_A.append(dfa)
        # df = np.array(df)
        # print(df)
        # vel_datas.append(df)
    print(len(vel_X))
    vel_X = np.array(vel_X)
    vel_Y = np.array(vel_Y)
    vel_A = np.array(vel_A)
    # print(vel_X)
    # print(vel_Y)
    # print(vel_A)
    print(vel_X.shape)
    return vel_X, vel_Y, vel_A


def get_batch():
    global BATCH_START, TIME_STEPS    
    # xs shape (50batch, 20steps)    
    # 创建等差数列
    xs = np.arange(BATCH_START, BATCH_START+TIME_STEPS*BATCH_SIZE).reshape((BATCH_SIZE, TIME_STEPS))  / (10*np.pi)    
    # print(xs[0])
    # print(xs.shape)
    seq = np.sin(xs)    
    res = np.cos(xs)    
    BATCH_START += TIME_STEPS    
    # plt.plot(xs[0, :], res[0, :], 'r', xs[0, :], seq[0, :], 'b--')    
    # plt.show()    
    # returned seq, res and xs: shape (batch, step, input)    
    return [seq[:, :, np.newaxis], res[:, :, np.newaxis], xs]  # 给原数组增加一个维度

def train_CNN():
    train_data, train_targets, test_data, test_targets = load_imdata('images_data')
    input_shape = (199, 230, 1)
    input_init = Input(shape=input_shape)
    pred_Y = CNN.build(input_init)
    
    # Gau_L = Conv2D(1, (5, 2), strides=(5, 2), border_mode='same', activation='relu')(processed)
    # x = Flatten()(Gau_L)
    # pred = Dense(1, activation='relu')(x)
    # pred = K.squeeze(x)
    model = Model(input_init, pred_Y)
    sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
    model.summary()


def train_LSTM():
    model = model_set.LSTMRNN(TIME_STEPS, INPUT_SIZE, OUTPUT_SIZE, CELL_SIZE, BATCH_SIZE)    
    sess = tf.Session()    
    merged = tf.summary.merge_all()    
    writer = tf.summary.FileWriter("logs", sess.graph)    
    # tf.initialize_all_variables() no long valid from       
    if int((tf.__version__).split('.')[1]) < 12 and int((tf.__version__).split('.')[0]) < 1:        
        init = tf.initialize_all_variables()    
    else:        
        init = tf.global_variables_initializer()    
    sess.run(init)    
    # relocate to the local dir and run this line to view it on Chrome (http://0.0.0.0:6006/):    
    # $ tensorboard --logdir='logs'     
    plt.ion()    
    plt.show()
    trdata_seq, trdata_res, trdata_xs = get_rnndata()    
    for i in range(len(trdata_seq)):
        seq = trdata_seq[i]
        res = trdata_res[i]
        xs = trdata_xs[i]
    # for i in range(200):        
    #     seq, res, xs = get_batch() 
    #     print(seq.shape)       
    #     print(res.shape)   
    #     print(res.shape)   
        if i == 0:            
            feed_dict = {                    
                model.xs: seq,                    
                model.ys: res,                    # create initial state            
                }        
        else:            
            feed_dict = {                
                model.xs: seq,                
                model.ys: res,                
                model.cell_init_state: state    # use last state as the initial state for this run
                }         
        _, cost, state, pred = sess.run(
                    [model.train_op, model.cost, model.cell_final_state, model.pred],            
                    feed_dict=feed_dict)      
       
                    
    # plotting        
    # plt.plot(xs[0, :], res[0].flatten(), 'r', xs[0, :], pred.flatten()[:TIME_STEPS], 'b--')  
    plt.plot(trdata_xs[0][0, :], trdata_res[0][0].flatten(), 'r', trdata_xs[0][0, :], pred.flatten()[:TIME_STEPS], 'b--')      
    plt.ylim((-1.2, 1.2))      
    # plt.show()  
    plt.draw()        
    plt.pause(100)


def run_kerasLSTM():
    trdata_seq, trdata_res, trdata_xs = get_rnndata() 
    
    trdata_xs = trdata_xs.reshape(trdata_xs.shape[0], trdata_xs.shape[2], 1).astype('float32')
    trdata_seq = trdata_seq.reshape(trdata_seq.shape[0], trdata_seq.shape[2],1).astype('float32')
    trdata_res = trdata_res.reshape(trdata_res.shape[0], trdata_res.shape[2],1).astype('float32')

    X_train = trdata_xs[:400, :]
    print("X_train:",X_train.shape)
    Y_train = trdata_seq[:400, :]
    print("Y_train:",Y_train.shape)
    # Y_train = trdata_xs[:400, :]
    X_valid = trdata_xs[400:, :]
    print("X_valid:",X_valid.shape)
    Y_valid = trdata_seq[400:, :]
    print("Y_valid:",Y_valid.shape)
    # Y_valid = trdata_xs[400:, :]

    input_shape = (300, 1)
    input_init = Input(shape=input_shape)
    pred_Y = kerasLSTM.build(input_init)
    model = Model(input_init, pred_Y)
    model.summary()
    model.compile(loss='mean_squared_error', 
                optimizer='adam', # rmsprop
                metrics=['mae', 'acc']) #metrics=['accuracy']
    history = model.fit(X_train, Y_train,
            batch_size=50,
            epochs=30,
            validation_data=(X_valid, Y_valid),
            )
    # model.save(tofname)
    prediction = model.predict(X_train)
    print(prediction[399])
    print(Y_train[399])
    plt.plot(X_train[399],prediction[399], 'r', X_train[399],Y_train[399], '-')
    plt.show() 

def train_model():
    ''' 训练CNN和LSTM联合网络 '''
    print("Train Begin:")

    trdata_seq, trdata_res, trdata_xs = get_rnndata() 
    trdata_xs = trdata_xs.reshape(trdata_xs.shape[0], trdata_xs.shape[2], 1).astype('float32')

    # train_data, train_targets, test_data, test_targets = load_imdata('images_data')
    # vel_X, vel_Y, vel_A = get_vel("vel_data")
    # coord_marix = load_sf("data")

    train_data = load_imdata('full_data/1/images_data')
    vel_X, vel_Y, vel_A = get_vel("full_data/1/vel_data")
    coord_marix = load_sf("full_data/1/data")

    x_valid_img = load_imdata('full_data/20/images_data')
    vel_X_valid, vel_Y_valid, vel_A_valid = get_vel("full_data/20/vel_data")
    x_valid_coor = load_sf("full_data/20/data")

    Y_valid = vel_X_valid

    for i in range(2):
        if i >= 2:
            print("temp:",i)
            # print("full_data/"+str(i)+"/images_data")
            train_tem = load_imdata("full_data/"+str(i)+"/images_data")
            # print(train_tem.shape)
            # print(i)
            vel_X_tem, vel_Y_tem, vel_A_tem = get_vel("full_data/"+str(i)+"/vel_data")
            # vel_X, vel_Y, vel_A = get_vel("full_data/2/vel_data")
            # print("full_data/"+str(i)+"/vel_data")
            coord_marix_tem = load_sf("full_data/"+str(i)+"/data")
            train_data = np.row_stack((train_data, train_tem))
            vel_X = np.row_stack((vel_X, vel_X_tem))
            vel_Y = np.row_stack((vel_Y, vel_Y_tem))
            vel_A = np.row_stack((vel_A, vel_A_tem))
            coord_marix = np.row_stack((coord_marix, coord_marix_tem))
    print(train_data.shape)
    print(vel_X.shape)
    print(vel_Y.shape)
    print(vel_A.shape)
    print(coord_marix.shape)



    x_train_img = train_data
    # x_train_img = x_train_img.reshape((-1,199,320,1))
    # x_train_img = np.tile(x_train_img, (64, 1, 1, 1))
    print('x_train_img:', x_train_img.shape)
    x_train_coor = coord_marix
    print('x_train_coor:', x_train_coor.shape)
    y_train = vel_X
    print('y_train:', y_train.shape)

    input_shape_img = (199, 320, 1)
    input_init_img = Input(shape=input_shape_img)
    input_shape_coor = (3, 100, 1)
    input_init_coor = Input(shape=input_shape_coor)

    processed_img = CNN.build(input_init_img)
    processed_coor = input_init_coor
    
    # my_concat = Lambda(lambda x: K.concatenate([x[0],x[1]],axis=-1))
    # output = my_concat([input1,input2])
    CNN_reshape = Lambda(lambda x: K.reshape(x, (-1, 3, 100, 1)))
    processed_img = CNN_reshape(processed_img)
    merged_layer = Concatenate(axis=-1)([processed_img, processed_coor])
    x = Flatten()(merged_layer)
    x = Dense(350)(x)

    print("before:",tf.shape(x))
    my_reshape = Lambda(lambda x: K.reshape(x, (-1,350,1)))
    x = my_reshape(x)
    print("after:",tf.shape(x))
    # x.reshape(-1, 100, 1) 
    # x = Conv2D(2, (8, 8), strides=(8, 8), border_mode='same', activation='relu')(merged_layer)
    # x = Flatten()(x)
    # x = GRU(128, input_shape=(350,1), return_sequences=True)(x)
    x = Bidirectional(GRU(128, input_shape=(350,1), return_sequences=True), merge_mode='ave')(x)
    out = TimeDistributed(Dense(1))(x)

    model_X = Model([input_init_img,input_init_coor], out)
    model_X.summary()
    model_X.compile(loss='mean_squared_error', 
                optimizer='rmsprop', # rmsprop
                metrics=['mae', 'acc']) #metrics=['accuracy']
    history = model_X.fit([x_train_img,x_train_coor], y_train,
            batch_size=BATCH_SIZES,
            epochs=EPOCHS,
            # validation_data=([x_valid_img,x_valid_coor], Y_valid),
            ) # validation_data=(X_valid, Y_valid),

    model_X.save("my_model/X_vel_model.h5")
    prediction = model_X.predict([x_train_img,x_train_coor])
    print(prediction[0])

    y_pred = model_X.predict([x_train_img,x_train_coor])
    plt.plot(trdata_xs[0], y_pred[15], 'r', trdata_xs[0], y_train[15], 'b')
    plt.show()
    del model_X

    # y_train = vel_Y
    # model_Y = Model([input_init_img,input_init_coor], out)
    # model_Y.summary()
    # model_Y.compile(loss='mean_squared_error', 
    #             optimizer='adam', # rmsprop
    #             metrics=['mae', 'acc']) #metrics=['accuracy']
    # history = model_Y.fit([x_train_img,x_train_coor], y_train,
    #         batch_size=BATCH_SIZES,
    #         epochs=EPOCHS,
            
    #         ) # validation_data=(X_valid, Y_valid),


    # model_Y.save("my_model/Y_vel_model.h5")
    # prediction = model_Y.predict([x_train_img,x_train_coor])
    # print(prediction[0])
    # del model_Y

    # y_train = vel_A
    # model_A = Model([input_init_img,input_init_coor], out)
    # model_A.summary()
    # model_A.compile(loss='mean_squared_error', 
    #             optimizer='adam', # rmsprop
    #             metrics=['mae', 'acc']) #metrics=['accuracy']
    # history = model_A.fit([x_train_img,x_train_coor], y_train,
    #         batch_size=BATCH_SIZES,
    #         epochs=EPOCHS,
            
    #         ) # validation_data=(X_valid, Y_valid),

    # model_A.save("my_model/A_vel_model.h5")
    # # prediction = model_A.predict([x_train_img,x_train_coor])
    # # print(prediction[0])
    # y_pred = model_A.predict([x_train_img,x_train_coor])
    # plt.plot(trdata_xs[25], y_pred[25], 'r', trdata_xs[25], y_train[25], 'b')
    # plt.show()

    # prediction = model_A.predict([x_train_img,x_train_coor])
    # print(prediction[0])
    # del model_A



def load_m(file_name):
    trdata_seq, trdata_res, trdata_xs = get_rnndata() 
    trdata_xs = trdata_xs.reshape(trdata_xs.shape[0], trdata_xs.shape[2], 1).astype('float32')

    train_data = load_imdata('full_data/1/images_data')
    vel_X, vel_Y, vel_A = get_vel("full_data/1/vel_data")
    coord_marix = load_sf("full_data/1/data")

    # for i in range(21):
    #     if i >= 2:
    #         train_tem = load_imdata('full_data/'+str(i)+'/images_data')
    #         vel_X_tem, vel_Y_tem, vel_A_tem = get_vel("full_data/1/vel_data")


    x_train_img = train_data
    # x_train_img = x_train_img.reshape((-1,199,320,1))
    # x_train_img = np.tile(x_train_img, (64, 1, 1, 1))
    print('x_train_img:', x_train_img.shape)
    x_train_coor = coord_marix
    print('x_train_coor:', x_train_coor.shape)
    y_train = vel_X
    print('y_train:', y_train.shape)

    model = load_model(file_name)
    y_pred = model.predict([x_train_img,x_train_coor])
    plt.plot(trdata_xs[0], y_pred[6], 'r', trdata_xs[0], y_train[6], 'b')
    plt.show()

if __name__ == '__main__':    
    # train_CNN()
    # train_LSTM()
    # get_batch()
    # get_rnndata()
    # get_vel("vel_data")
    # load_sf("data")
    # run_kerasLSTM()
    train_model()
    # load_m("my_model/X_vel_model.h5")

          
