Whether you want to build a self balance robot or why not, a drone you need an accelerometer module.

The MPU-6050 accelerometer module, needs to be calibrated before it is used for the first time.

The objective is to get zero-error, therefore we need to adjust the offsets in order to counteract all the errors.

As you know each MPU6050 sensor has its own values of offsets.  Fortunately there are two programs  developed by  by Jeff Rowberg that can calibrate the MPU-6050 .

Step 1: https://github.com/aos92/Mobil-Roda-Dua/blob/main/MPU6050/MPU6050_calibration.ino

Step 2: https://github.com/aos92/Mobil-Roda-Dua/blob/main/MPU6050/MPU6050_latest_code.ino

In order to use the programs, you have to upload the sketch and then place the accel-gyro module in a flat and level position. The program will display the offsets required to remove zero error.

Below are two screenshots of the two programs:

https://github.com/aos92/Mobil-Roda-Dua/blob/main/MPU6050/calibration.png

Please use the values found to enter them in the next program:

https://github.com/aos92/Mobil-Roda-Dua/blob/main/MPU6050/latest-code.png

If after this last check the result is zero then these values must be used in your sketch, to compensate for errors.

https://github.com/aos92/Mobil-Roda-Dua/blob/main/MPU6050/new-values.png

Link detail:
https://microcontrolere.wordpress.com/2021/06/06/how-to-calibrate-the-mpu6050-sensor/
