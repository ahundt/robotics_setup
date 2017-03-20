"""Code for building the input for the prediction model.
V1 from https://sites.google.com/site/brainrobotdata/home/push-dataset
requires moviepy package
"""

import os

import numpy as np
import tensorflow as tf

from tensorflow.python.platform import flags
from tensorflow.python.platform import gfile


FLAGS = flags.FLAGS

# Original image dimensions
ORIGINAL_WIDTH = 640
ORIGINAL_HEIGHT = 512
COLOR_CHAN = 3
BATCH_SIZE = 25

def build_image_input(train=True, novel=True):
  """Create input tfrecord tensors.

  Args:
    novel: whether or not to grab novel or seen images.
  Returns:
    list of tensors corresponding to images. The images
    tensor is 5D, batch x time x height x width x channels.
  Raises:
    RuntimeError: if no files found.
  """
  if train:
    data_dir = 'push/push_train'
  elif novel:
    data_dir = 'push/push_testnovel'
  else:
    data_dir = 'push/push_testseen'
  filenames = gfile.Glob(os.path.join(data_dir, '*'))
  if not filenames:
    raise RuntimeError('No data files found.')
  filename_queue = tf.train.string_input_producer(filenames, shuffle=False)
  reader = tf.TFRecordReader()
  _, serialized_example = reader.read(filename_queue)

  image_seq = []

  for i in range(25):
    image_name = 'move/' + str(i) + '/image/encoded'
    features = {image_name: tf.FixedLenFeature([1], tf.string)}
    features = tf.parse_single_example(serialized_example, features=features)

    image_buffer = tf.reshape(features[image_name], shape=[])
    image = tf.image.decode_jpeg(image_buffer, channels=COLOR_CHAN)
    image.set_shape([ORIGINAL_HEIGHT, ORIGINAL_WIDTH, COLOR_CHAN])

    image = tf.reshape(image, [1, ORIGINAL_HEIGHT, ORIGINAL_WIDTH, COLOR_CHAN])
    # image = tf.image.resize_bicubic(image, [IMG_HEIGHT, IMG_WIDTH])
    image_seq.append(image)

  image_seq = tf.concat(0, image_seq)


  image_batch = tf.train.batch(
      [image_seq],
      BATCH_SIZE,
      num_threads=1,
      capacity=1)
  return image_batch

import moviepy.editor as mpy
def npy_to_gif(npy, filename):
    clip = mpy.ImageSequenceClip(list(npy), fps=10)
    clip.write_gif(filename)

train_image_tensor = build_image_input()
sess = tf.InteractiveSession()
tf.train.start_queue_runners(sess)
sess.run(tf.initialize_all_variables())
train_videos = sess.run(train_image_tensor)

for i in range(BATCH_SIZE):
    video = train_videos[i]
    npy_to_gif(video, '~/train_' + str(i) + '.gif')

