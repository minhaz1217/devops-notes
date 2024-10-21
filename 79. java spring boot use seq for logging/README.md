# Java spring boot use seq for logging

## Motivation

The primary motivation is that I use SEQ for logging, but I couldn't find a quick complete guide to use SEQ with java spring boot using gradle. So here I'm documenting my findings.

## Steps

### I'm using this configuration for the project

![Project setup](<images/01. spring boot project setup.png>)

### Add these to `build.gradle` for dependency

```
repositories {
    ...
	maven { url 'https://jitpack.io' }
}

dependencies {
    ...
    implementation 'com.github.serilogj:serilogj:v0.6.1'
}
```

### Now just configure the logger

```
// import serilogj.Log;
// import serilogj.LoggerConfiguration;
// import serilogj.events.LogEventLevel;
// import static serilogj.sinks.seq.SeqSinkConfigurator.seq;

// setting up the logger
Log.setLogger(new LoggerConfiguration()
        .writeTo(seq("http://localhost:5341/"))
        .setMinimumLevel(LogEventLevel.Verbose)
        .createLogger());

// using the logger
var logger = Log.getLogger().forContext(SpringApplication.class);
logger.information("Hello World");
```

With this setup the logger should work
![SEQ Working](<images/02. logger working.png>)

You can find the code [here](https://github.com/minhaz1217/java-quarkus/tree/master/spring-boot-seq)

This was published in [medium](https://medium.com/@minhaz1217/java-spring-boot-use-seq-for-logging-230fad9e4b62) and [dev.to](https://dev.to/minhaz1217/java-spring-boot-use-seq-for-logging-39fm)

### Reference

1. [https://docs.datalust.co/docs/using-java](https://docs.datalust.co/docs/using-java)
2. [My blog](https://github.com/minhaz1217/devops-notes/tree/master/79.%20java%20spring%20boot%20use%20seq%20for%20logging)
3. [Source Code](https://github.com/minhaz1217/java-quarkus/tree/master/spring-boot-seq)
