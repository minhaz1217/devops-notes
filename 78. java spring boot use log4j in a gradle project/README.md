# How to use log4j in a java spring boot gradle project

## Motivation

The motivation here is that I've spent just too much time trying to figure out how to add logging with log4j in spring boot in **gradle**. Here the gradle part was the one giving me the most grief because all the documentations I could find was for maven.

So I'm documenting my findings here so that next person who is looking for this might find my post and will be able to figure it out quickly.

### This is the configuration I'm using for the demo. I've tested the same implementation in java 17 as well.

![Project setup](./images/01.%20project%20setup.png)

### Add this line to the `build.gradle`

```
configurations {
	all*.exclude module : 'spring-boot-starter-logging'
}

dependencies {
    ...
    implementation "org.springframework.boot:spring-boot-starter-log4j2"
}
```

### Create a file named `log4j2.xml` in the `src/main/resources` folder and add this to the file

```

<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="INFO">
    <Appenders>
        <Console name="console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - Message: %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <Root level="trace">
            <AppenderRef ref="console"/>
        </Root>
    </Loggers>
</Configuration>
```

Your setup is done, now you can add logger from log4j and it will use this xml configuration. Notice that I've added a `Message:` in every message. So if you don't want it, you can just remove it. I've added it there so that I can test whether or not the project was using this xml file.

### Now to test you can just use the log4j logger. You can add it in the `main` method.

```
// import org.apache.logging.log4j.LogManager;
// import org.apache.logging.log4j.Logger;

Logger logger = LogManager.getLogger(SpringApplication.class);
logger.info("Hello World!");
```

The logger setup should work as expected. Notice the `Message:` part.

![Logging working](./images/02.%20logs%20working.png)

You can find the project [here](https://github.com/minhaz1217/java-quarkus/tree/master/spring-boot-log4j)

## References

1. (https://www.sentinelone.com/blog/started-quickly-spring-boot-logging/)[https://www.sentinelone.com/blog/started-quickly-spring-boot-logging/]
2. (https://github.com/minhaz1217/devops-notes/tree/master/78.%20java%20spring%20boot%20use%20log4j%20in%20a%20gradle%20project)[https://github.com/minhaz1217/devops-notes/tree/master/78.%20java%20spring%20boot%20use%20log4j%20in%20a%20gradle%20project]
3. [The dummy project](https://github.com/minhaz1217/java-quarkus/tree/master/spring-boot-log4j)

#

# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
