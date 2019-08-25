from keras.models import load_model
import os.path
import re
from PIL import Image
import numpy as np
import cv2
import matplotlib.pyplot as plt  
from train import get_rnndata, load_imdata, get_vel, load_sf

LEN_VEL = 500
TIME_STEPS = LEN_VEL

def predict_model(file_name):
    ''' 读取已经训练好的模型'''
    model = load_model(file_name)

    # y_pred = model.predict([x_pred_img, x_pred_coor])
    trdata_seq, trdata_res, trdata_xs = get_rnndata() 
    trdata_xs = trdata_xs.reshape(trdata_xs.shape[0], trdata_xs.shape[2], 1).astype('float32')

    train_data = load_imdata('predict_data/exm/images_data')
    vel_X, vel_Y, vel_A = get_vel("predict_data/exm/vel_data")
    coord_marix = load_sf("predict_data/exm/data")

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

    y_pred = model.predict([x_train_img,x_train_coor])
    print(type(y_pred))
    plt.plot(trdata_xs[0], y_pred[0], 'r')
    plt.show()


if __name__ == "__main__":
    # load_image("predict_data")
    predict_model("my_model/X_vel_model.h5")
    