from __future__ import absolute_import
from __future__ import print_function
import numpy as np
from keras.models import Model, Sequential
from keras.layers import Input, Flatten, Dense, Dropout, Lambda, Conv2D, MaxPooling2D
from keras.optimizers import RMSprop
from keras import backend as K
from keras.optimizers import SGD
import re
import os.path
import pandas as pd


EPOCH = 50

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
    # X_im = np.array(X_im)
    return X_im

class CNN:
    @staticmethod
    def build(input_shape):
        input = Input(shape=input_shape)
        x = Conv2D(64, (3, 3))(input)
        # x = Conv2D(128, (3, 3))(x)
        x = MaxPooling2D((2, 2))(x)
        # x = Conv2D(256, (3, 3))(x)
        x = Flatten()(x)
        # x = Dense(16, activation='relu')(x)
        # x = Dropout(0.1)(x)
        x = Dense(1, activation='sigmoid')(x)
        return Model(input,x)

x_imdata = load_imdata('images_data')
split_num = int(len(x_imdata)-len(x_imdata)/8)
train_data = x_imdata[:6]
train_targets = [1,0,1,1,0,1]
train_targets = np.array(train_targets)
print(train_targets.shape)
print(train_targets)
test_data = x_imdata[6:8]
test_targets = [1,1]
test_targets = np.array(test_targets)
input_shape = (199, 230, 1)

model = CNN.build(input_shape)
sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
model.summary()
# 配置模型
model.compile(
            loss='categorical_crossentropy',
            optimizer=sgd,
            metrics=['accuracy'])
#训练模型
H = model.fit(
            x=train_data,
            y =train_targets,
            epochs=EPOCH,
            batch_size=1)
# 计算评估结果
score = model.evaluate(x=test_data,
                        y=test_targets,
                        batch_size=1)

predict_test = model.predict(test_data)  
predict = np.argmax(predict_test,axis=1)  #axis = 1是取行的最大值的索引，0是列的最大值的索引
# inverted = encoder.inverse_transform([predict])  
print(predict_test,'\n',len(predict_test[0]))  

print(predict)