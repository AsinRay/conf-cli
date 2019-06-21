#!/usr/bin/env bash

# =====================================
# #@ 项目启动脚本
# boot目录： spring boot jar 包
# config目录：配置文件目录
# logs目录： 项目运行日志目录
# logs/startup.log: 启动日志
# logs/back目录： 项目运行日志备份目录
# nohup 后台运行
# =====================================

# 项目名称
APPLICATION="@project.name@"

# 项目启动jar包名称
APP_JAR="@build.finalName@.jar"

# bin目录的绝对路径
BIN_PATH=$(cd `dirname $0`; pwd)
cd `dirname $0`
cd ..
BASE_PATH=`pwd`


java  -Dloader.path=../lib,../config -Dloder.config.location=../config -jar ../boot/conf-cli-1.0.0.jar


# 外部配置文件的绝对路经，如果是目录需要以/结尾，也可直接指定文件
# 如果指定的是目录，spring则会读取目录中的所有配置文件
CNF_DIR=${BASE_PATH}"/config/"

# 项目日志输出绝对路径
LOG_DIR=${BASE_PATH}"/logs"

# 日志备份目录
LOG_BACK_DIR="${LOG_DIR}/back/"

# 项目启动日志输出的绝路径
START_LOG="${LOG_DIR}/startup.log"

# 准备启动JVM进程

# 如果logs文件夹不存在，则创建之

if [[ !-d "${LOG_DIR}" ]]; then
    mkdir "${LOG_DIR}"
fi

# 如果logs/back文件夹不存在，则创建文件夹

if [[ ! -d "${LOG_BACK_DIR}" ]]; then
    mkdir "${LOG_BACK_DIR}"
fi

# 如果项目运行日志存在，则重命名备份

if [[ -f "${LOG_PATH}"]]; then
    mv ${LOG_PATH} "${LOG_BACK_DIR}/${APPLICATION}_back_${NOW}.log"
fi

# 创建新的项目运行日志

echo "" > ${START_LOG}



# ==========================================================================================
# JVM Configuration
# -Xmx256m:设置JVM最大可用内存为256m,根据项目实际情况而定，建议最小和最大设置成一样。
# -Xms256m:设置JVM初始内存。此值可以设置与-Xmx相同,以避免每次垃圾回收完成后JVM重新分配内存
# -Xmn512m:设置年轻代大小为512m。整个JVM内存大小=年轻代大小 + 年老代大小 + 持久代大小。
#          持久代一般固定大小为64m,所以增大年轻代,将会减小年老代大小。此值对系统性能影响较大,Sun官方推荐配置为整个堆的3/8
# -XX:MetaspaceSize=64m:存储class的内存大小,该值越大触发Metaspace GC的时机就越晚
# -XX:MaxMetaspaceSize=320m:限制Metaspace增长的上限，防止因为某些情况导致Metaspace无限的使用本地内存，影响到其他程序
# -XX:-OmitStackTraceInFastThrow:解决重复异常不打印堆栈信息问题
#==========================================================================================
JAVA_OPT="-server -Xms256m -Xmx256m -Xmn512m -XX:MetaspaceSize=64m -XX:MaxMetaspaceSize=256m"
JAVA_OPT="${JAVA_OPT} -XX:-OmitStackTraceInFastThrow"

#=======================================================
# 将命令启动相关日志追加到日志文件
#=======================================================

# 输出项目名称
STARTUP_LOG="${STARTUP_LOG}application name: ${APPLICATION}\n"
# 输出jar包名称
STARTUP_LOG="${STARTUP_LOG}application jar  name: ${APPLICATION_JAR}\n"
# 输出项目根目录
STARTUP_LOG="${STARTUP_LOG}application root path: ${BASE_PATH}\n"
# 输出项目bin路径
STARTUP_LOG="${STARTUP_LOG}application bin  path: ${BIN_PATH}\n"
# 输出项目config路径
STARTUP_LOG="${STARTUP_LOG}application config path: ${CONFIG_DIR}\n"
# 打印日志路径
STARTUP_LOG="${STARTUP_LOG}application log  path: ${LOG_PATH}\n"
# 打印JVM配置
STARTUP_LOG="${STARTUP_LOG}application JAVA_OPT : ${JAVA_OPT}\n"


# 打印启动命令
STARTUP_LOG="${STARTUP_LOG}application startup command: nohup java ${JAVA_OPT} -jar ${BASE_PATH}/boot/${APPLICATION_JAR} --spring.config.location=${CONFIG_DIR} > ${LOG_PATH} 2>&1 &\n"


#======================================================================
# 执行启动命令：后台启动项目,并将日志输出到项目根目录下的logs文件夹下
#======================================================================
nohup java ${JAVA_OPT} -jar ${BASE_PATH}/boot/${APPLICATION_JAR}




 --spring.config.location=${CONFIG_DIR} > ${LOG_PATH} 2>&1 &


# 进程ID
PID=$(ps -ef | grep "${APPLICATION_JAR}" | grep -v grep | awk '{ print $2 }')
STARTUP_LOG="${STARTUP_LOG}application pid: ${PID}\n"

# 启动日志追加到启动日志文件中
echo -e ${STARTUP_LOG} >> ${LOG_STARTUP_PATH}
# 打印启动日志
echo -e ${STARTUP_LOG}

# 打印项目日志
tail -f ${LOG_PATH}