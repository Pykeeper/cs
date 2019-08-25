import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import time
import re
import os.path
# from keras.utils import to_categorical


def load_data(input_file):
    ''' load data '''
    print("Load Data:\n")
    dataset = np.loadtxt(input_file, delimiter=",")
    print("Done")
    print(len(dataset))
    return dataset
    # train_targets = []
    # test_targets = []
    # # 数据选择——训练集
    # for n in [15]:
    #     train_data = dataset[15:, :14]
    #     train_target = to_categorical(dataset[15:, n], num_classes=4) #num_classes>

    #     # 数据选择——测试集
    #     test_data = dataset[:15, :14]
    #     test_target = to_categorical(dataset[:15, n], num_classes=4)
    #     # test_targets = dataset[15:, 5:]
    #     # test_targets = test_targets.astype(int) # 将标签转换为int类型
    #     #数据标准化
    #     mean = train_data.mean(axis=0)
    #     train_data -= mean
    #     std = train_data.std(axis=0)
    #     train_data /= std
    #     test_data -= mean
    #     test_data /= std
    #     train_targets.append(train_target)
    #     test_targets.append(test_target)
    # return train_data, train_targets, test_data, test_targets

def readwrite(input_file,output_file):
    data_f=pd.read_csv(input_file,names=['StaX', 'StaY', 'StaA', 
                                         'VelX', 'VelY', 'VelA',
                                         'EndX', 'EndY', 'EndA', 'image'],sep=',')
    print(type(data_f), '\t', data_f.shape)
    # print(data_f[[0]].shape)
    data_f[['StaX', 'StaY', 'StaA', 
            'VelX', 'VelY', 'VelA',
            'EndX', 'EndY', 'EndA']].to_csv(output_file, sep=',', header=False,index=False)
    

def getRunTimes( fun ,input_file,output_file,fun_name):
    begin_time=int(round(time.time() * 1000))
    fun(input_file,output_file)
    end_time=int(round(time.time() * 1000))
    print(fun_name,(end_time-begin_time),"ms")


def plot(data):
    # x = np.linspace(0,len(data)-1,len(data))
    x = data[:,0]
    StaX = data[:,0]
    StaY = data[:,1]
    StaA = data[:,3]
    VelX = data[:,3]
    VelY = data[:,4]
    VelA = data[:,5]
    EndX = data[:,6]
    EndY = data[:,7]
    EndA = data[:,8]
    # VelA = data[:,5]

    # plt.figure(figsize=(8,4))

    plt.plot(x,VelX,label="VelX",color="red",linewidth=2)
    plt.plot(x,VelY,color=(0,1,1),label="VelY")
    plt.plot(x,VelA,color=(0,0.5,1),label="VelA")

    plt.xlabel("Time(/0.1s)")
    plt.ylabel("Velctory")
    # plt.xlabel("Time(s)")
    # plt.ylabel("Volt")
    plt.title("PyPlot Data")


    # plt.ylim(-1.5,1.5)
    plt.legend()

    plt.show()


def load_imdata(input_file):
    image_datas = []
    X_im = []
    pathDir_1 =  os.listdir(input_file)
    for allDir_1 in pathDir_1:
        child = os.path.join('%s\%s' % (input_file, allDir_1))
        df=pd.read_csv(child)
        image_datas.append(df)
    for data in image_datas:
        # print(data.shape)
        x = data.values.reshape(-1, data.shape[0], data.shape[1], 1).astype('float32') / 255.
        X_im.append(x)
    print(len(X_im))
    return X_im


if __name__ == "__main__":
    # getRunTimes(readwrite,'telemetry.csv','tm_data.csv', "transfer csv：") 
    # # readwrite2('telemetry.csv', 'tm_data.csv')
    # dataset = load_data('tm_data.csv')
    # plot(dataset)
    # x_imdata = load_imdata('images_data') 

    




