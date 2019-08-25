#!/usr/bin/env python
# coding: utf8

import os
from datetime import datetime
import random
from PIL import Image
import array
import yaml

import rospy
import tf
import angles
from nav_msgs.msg import Odometry, OccupancyGrid
from geometry_msgs.msg import Twist, Pose2D, PoseStamped, Quaternion

__author__ = "Coelen Vincent"
__copyright__ = "2019, Association de Robotique de Polytech Lille All rights reserved"
__credits__ = ["Coelen Vincent", ]
__license__ = ""
__version__ = ""
__maintainer__ = "Coelen Vincent"
__email__ = "vincent.coelen@polytech-lille.net"
__status__ = "Developpement"


g_map = None
g_mapImg = None
g_lut = [255*i/100 for i in xrange(100, 0, -1)] + [0 for i in xrange(256-100)]
g_odom = None

def gridmap_cb(map):
    global g_map
    global g_mapImg
    global g_lut

    g_map = map
    #Convert to image
    g_mapImg = Image.frombuffer("L",(g_map.info.width, g_map.info.height), array.array('B', g_map.data).tostring() ,"raw","L",0,1)
    g_mapImg = g_mapImg.point(g_lut)


def odom_cb(odom):
    global g_odom
    g_odom = odom

def getGridCellValue(map, pose):

    xBoundMin = map.info.origin.position.x
    xBoundMax = xBoundMin + map.info.width * map.info.resolution
    yBoundMin = map.info.origin.position.y
    yBoundMax = yBoundMin + map.info.height * map.info.resolution

    if not(xBoundMin < pose.x < xBoundMax) or not(yBoundMin < pose.y < yBoundMax) :
        return None

    h = int(round((pose.y - map.info.origin.position.y)/map.info.resolution))
    w = int(round((pose.x - map.info.origin.position.x)/map.info.resolution))

    cellValue = h * map.info.width + w

    return map.data[cellValue]

def isValide(pose):
    if pose is None:
        return False
    # Position is not an entry
    if  (-7 <= pose.x <= -4 and 0 <= pose.y <= 1) or (4 <= pose.x <= 7 and 0 <= pose.y <= 1):
        return False
    # Posision is not an obstacle
    value = getGridCellValue(g_map, pose)
    print value
    if value is not None and value < 85:
        return True
    return False

def generateNewDestination():
    pose = Pose2D()
     # TODO: (vincent) Magic number : use parameters instead
    pose.x = random.uniform(-7.0, 7.0)
    pose.y = random.uniform(0.0, 7.0)
    pose.theta = random.uniform(-3.14159, 3.14159)
    while not isValide(pose):
        #Randomly choose a position
        pose.x = random.uniform(-7.0, 7.0)
        pose.y = random.uniform(0.0, 7.0)
        pose.theta = random.uniform(-3.14159, 3.14159)
        #Or randomly choose an Input/Output of a machine
    return pose

def robotAtDestination(pose, twist, destination):
    distRange = 0.1 #10cm
    distAngle = 0.5 #rad
    nullSpeedThresh = 0.01 #m/s or rad/s
    quaternion = (
        pose.pose.orientation.x,
        pose.pose.orientation.y,
        pose.pose.orientation.z,
        pose.pose.orientation.w)
    euler = tf.transformations.euler_from_quaternion(quaternion)
    yaw = euler[2]

    return abs(pose.pose.position.x - destination.x) <= distRange \
        and abs(pose.pose.position.y - destination.y) <= distRange \
        and abs(angles.shortest_angular_distance(yaw, destination.theta)) < distAngle \
        and abs(twist.twist.linear.x) < nullSpeedThresh \
        and abs(twist.twist.linear.y) < nullSpeedThresh \
        and abs(twist.twist.angular.z) < nullSpeedThresh

if __name__ == '__main__':
    global g_map
    global g_mapImg
    global g_odom

    g_map = None
    g_odom = None

    rospy.init_node('GenerateWaypoints.py')

    rospy.Subscriber("/robotino1/objectDetection/gridObstacles", OccupancyGrid, gridmap_cb)
    rospy.Subscriber("/robotino1/hardware/odom", Odometry, odom_cb)
    destination_pub = rospy.Publisher('destination', Odometry, queue_size=10, latch = True)
    moveBase_pub = rospy.Publisher('move_base_simple/goal', PoseStamped, queue_size=10, latch = True)

    tfListener = tf.TransformListener()
    destination_br = tf.TransformBroadcaster()

    rospy.loginfo("Wait for map and odom")
    rate = rospy.Rate(10)
    while g_map is None and g_odom is None and not rospy.is_shutdown():
        rate.sleep()

    rate2 = rospy.Rate(1)
    rate2.sleep()

    rospy.loginfo("Map and odom received")
    poseInMap = PoseStamped()
    tempPoseStamped = PoseStamped()
    tempPoseStamped.header = g_odom.header
    tempPoseStamped.pose = g_odom.pose.pose
    try:
        tfListener.waitForTransform(tempPoseStamped.header.frame_id, "map", rospy.Time(), rospy.Duration(1.0))
        poseInMap = tfListener.transformPose("map", tempPoseStamped)
    except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
        rospy.logwarn("Unable to get transform from %s to map" % tempPoseStamped.header.frame_id)



    # Create a new folder and Generate a filename with date and time
    today = datetime.now()
    directory = "data_" + today.strftime('%Y%m%d_%H:%M:%S')
    mapDirectory = directory +"/map"
    if not os.path.exists(directory):
        os.makedirs(directory)
        os.makedirs(mapDirectory)

    # Open the file in write mode
    fileTelemetry = open(directory + "/telemetry.txt", "w")

    fileMapMetaData = file(directory + '/mapMetaData.yaml', 'w')
    mapMetaData = dict()
    mapMetaData['resolution'] = g_map.info.resolution
    mapMetaData['width'] = g_map.info.width
    mapMetaData['height'] = g_map.info.height
    mapMetaData['resolution'] = g_map.info.resolution
    mapMetaData['origin'] = dict()
    mapMetaData['origin']['position'] = dict()
    mapMetaData['origin']['position']['x'] = g_map.info.origin.position.x
    mapMetaData['origin']['position']['y'] = g_map.info.origin.position.y
    mapMetaData['origin']['position']['z'] = g_map.info.origin.position.z
    mapMetaData['origin']['orientation'] = dict()
    mapMetaData['origin']['orientation']['x'] = g_map.info.origin.orientation.x
    mapMetaData['origin']['orientation']['y'] = g_map.info.origin.orientation.y
    mapMetaData['origin']['orientation']['z'] = g_map.info.origin.orientation.z
    mapMetaData['origin']['orientation']['w'] = g_map.info.origin.orientation.w
    yaml.dump(mapMetaData, fileMapMetaData)

    mapCount = 0



    # Choose randomly a new destination
    destination = generateNewDestination()
    # publish it
    destination_msg = Odometry()
    destination_msg.header.frame_id = "map"
    destination_msg.child_frame_id = "destination"
    destination_msg.header.stamp = rospy.Time.now()
    destination_msg.pose.pose.position.x = destination.x
    destination_msg.pose.pose.position.y = destination.y
    destination_msg.pose.pose.orientation = Quaternion(*tf.transformations.quaternion_from_euler(0, 0, destination.theta))
    destination_br.sendTransform((destination.x, destination.y, 0),
                     tf.transformations.quaternion_from_euler(0, 0, destination.theta),
                     rospy.Time.now(),
                     "destination",
                     "map")
    destination_pub.publish(destination_msg)

    moveBase_msg = PoseStamped()
    moveBase_msg.header = destination_msg.header
    moveBase_msg.pose = destination_msg.pose.pose
    moveBase_pub.publish(moveBase_msg)

    rospy.loginfo("Generate a new destination : " + str(destination_msg))

    while not rospy.is_shutdown():

        tempPoseStamped = PoseStamped()
        tempPoseStamped.header = g_odom.header
        tempPoseStamped.pose = g_odom.pose.pose
        try:
            tfListener.waitForTransform(tempPoseStamped.header.frame_id, "map", rospy.Time(), rospy.Duration(1.0))
            poseInMap = tfListener.transformPose("map", tempPoseStamped)
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            rospy.logwarn("Unable to get transform from %s to map" % tempPoseStamped.header.frame_id)
            quit()

        # save data in file (pose, speed, destination, link to map file)
        mapFilename = "map_{:09}.png".format(mapCount)
        g_mapImg.save(mapDirectory + "/" + mapFilename, format='PNG')


        quaternion = (
            poseInMap.pose.orientation.x,
            poseInMap.pose.orientation.y,
            poseInMap.pose.orientation.z,
            poseInMap.pose.orientation.w)
        euler = tf.transformations.euler_from_quaternion(quaternion)
        yaw = euler[2]
        fileTelemetry.write((9*'{},'+'{}\n').format(
            poseInMap.pose.position.x,
            poseInMap.pose.position.y,
            yaw,
            g_odom.twist.twist.linear.x,
            g_odom.twist.twist.linear.y,
            g_odom.twist.twist.angular.z,
            destination.x,
            destination.y,
            destination.theta,
            mapFilename))


        # if robot is at destination (pose and angular correct and null speed )
        if robotAtDestination(poseInMap, g_odom.twist, destination):
            rospy.loginfo("Robot reach destination")
            # Choose randomly a new destination
            destination = generateNewDestination()
            # publish it
            destination_msg = Odometry()
            destination_msg.header.frame_id = "map"
            destination_msg.child_frame_id = "destination"

            destination_msg.pose.pose.position.x = destination.x
            destination_msg.pose.pose.position.y = destination.y
            destination_msg.pose.pose.orientation = Quaternion(*tf.transformations.quaternion_from_euler(0, 0, destination.theta))
            rospy.loginfo("Generate a new destination : " + str(destination_msg))

            moveBase_msg.header = destination_msg.header
            moveBase_msg.pose = destination_msg.pose.pose
            moveBase_pub.publish(moveBase_msg)

            #Close the file and open a new one with a new name
            fileTelemetry.close()

            # Create a new folder and Generate a filename with date and time
            today = datetime.now()
            directory = "data_" + today.strftime('%Y%m%d_%H:%M:%S')
            mapDirectory = directory +"/map"
            if not os.path.exists(directory):
                os.makedirs(directory)
                os.makedirs(mapDirectory)

            # Open the file in write mode
            fileTelemetry = open(directory + "/telemetry.txt", "w")

            fileMapMetaData = file(directory + '/mapMetaData.yaml', 'w')
            mapMetaData = dict()
            mapMetaData['resolution'] = g_map.info.resolution
            mapMetaData['width'] = g_map.info.width
            mapMetaData['height'] = g_map.info.height
            mapMetaData['resolution'] = g_map.info.resolution
            mapMetaData['origin'] = dict()
            mapMetaData['origin']['position'] = dict()
            mapMetaData['origin']['position']['x'] = g_map.info.origin.position.x
            mapMetaData['origin']['position']['y'] = g_map.info.origin.position.y
            mapMetaData['origin']['position']['z'] = g_map.info.origin.position.z
            mapMetaData['origin']['orientation'] = dict()
            mapMetaData['origin']['orientation']['x'] = g_map.info.origin.orientation.x
            mapMetaData['origin']['orientation']['y'] = g_map.info.origin.orientation.y
            mapMetaData['origin']['orientation']['z'] = g_map.info.origin.orientation.z
            mapMetaData['origin']['orientation']['w'] = g_map.info.origin.orientation.w
            yaml.dump(mapMetaData, fileMapMetaData)

            #reset map count
            mapCount = 0


        destination_br.sendTransform((destination.x, destination.y, 0),
                         tf.transformations.quaternion_from_euler(0, 0, destination.theta),
                         rospy.Time.now(),
                         "destination",
                         "map")
        destination_msg.header.stamp = rospy.Time.now()
        destination_pub.publish(destination_msg)


        mapCount += 1
        rate.sleep()

    # close file
    f.close()
