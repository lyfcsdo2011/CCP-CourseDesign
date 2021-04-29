# CCP-CourseDesign
Computer Compose Principle Course Design.

We made a simple 5-stage pipeline CPU based on CDE project provided by Loongson.
We realized extend 27 instruction, using verilog.

# About platform
This is a vivado project, you need to create "xc7a200tfbg676-2" vivado project and import the CDE file if you want to run it on the test box.

# How to use

Just create project and import it! If you don't know how to import, baidu or google it!

You must replace CDE/cpu folder by using the cpu folder I pushed.

Besides, you can use Mars4_5.jar to turn assembly instructions into machine instructions.

# Trace Comparsion
Oh this is an advanced method to test your project to see if it's ok.

In a nutshell, you run a absolutely right project to generate a log file, which has no problems at all,  and run your project to generate your log file to compare it with the right one, if they are exactly the same, there is no problem with your project. It is complicated to say, if you want to know that how to work specifically, you can baidu or google or ask Loongson, or just call me.

I change the start.S, which will generate machine instruction for testing, you just replace CDE/soft/func/start.S with it, and cross compile it in linux into mips. You will use it when generate the log.