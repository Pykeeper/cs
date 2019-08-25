import tensorflow as tf

# e，即event，代表某一个batch的日志记录
for e in tf.train.summary_iterator('./log/events.out.tfevents.1551631548.DESKTOP-JJK0R4J'):
    # v，即value，代表这个batch的某个已记录的观测值，loss或者accuracy
    for v in e.summary.value:
        if v.tag == 'loss' or v.tag == 'accuracy':
            print(v.simple_value)