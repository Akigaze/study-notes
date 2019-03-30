# Spring Cloud
- Spring Cloud Netflix
    - Eureka
    - Hystrix
    - Zuul
    - Archaius
- Spring Cloud Config
- Spring Cloud Bus
- Spring Cloud for Cloud Foundry
- Spring Cloud Cluster
- Spring Cloud Consul
- Spring Cloud Security
- Spring Cloud Sleuth
- Spring Cloud Data Flow
- Spring Cloud Stream
- Spring Cloud Task
- Spring Cloud Zookeeper
- Spring Cloud Connectors
- Spring Cloud Starters
- Spring Cloud CLI

## Spring Cloud Netflix
Netflix 是Spring Cloud微服务规范的一套实现方案，而Spring Cloud微服务的实现方案还有其他，包括 Spring Cloud Alibaba 等，其中 Netflix 是最成熟的一套方案。

### Netflix Eureka
服务中心，云端服务发现，一个基于 REST 的服务，用于定位服务，以实现云端中间层服务发现和故障转移。

### Netflix Hystrix
熔断器，容错管理工具，旨在通过熔断机制控制服务和第三方库的节点,从而对延迟和故障提供更强大的容错能力。

### Netflix Zuul
Zuul 是在云平台上提供动态路由，监控，弹性，安全等边缘服务的框架。

### Netflix Archaius
配置管理API，包含一系列配置管理API，提供动态类型化属性、线程安全配置操作、轮询框架、回调机制等功能。

## Spring Cloud Config
俗称的配置中心，配置管理工具包，让你可以把配置放到远程服务器，集中化管理集群配置，目前支持本地存储、Git以及Subversion。

## Spring Cloud Security
基于spring security的安全工具包，为你的应用程序添加安全控制。

## Spring Cloud vs. Spring Boot
1. Spring Boot 是 Spring 的一套快速配置脚手架，可以基于Spring Boot 快速开发单个微服务
2. Spring Cloud是一个基于Spring Boot实现的云应用开发工具
3. Spring Boot专注于快速、方便集成的单个个体
4. Spring Cloud是关注全局的服务治理框架
5. Spring Boot使用了默认大于配置的理念，集成了很多配置方案
6. Spring Cloud很大的一部分是基于Spring Boot来实现

-----------

# 注册中心Eureka
## Eureka Server
### **application.yml**
```yml
server:
  port: 40001
eureka:
  client:
    register-with-eureka: false
    fetch-registry: false
    #service-url:
    #  default-zone: http://localhost:${server.port}/eureka/

logging:
  level:
    com:
      netflix:
        eureka: OFF
        discovery: OFF
spring:
  application:
    name: a-eureka-server
```

## Eureka Provider
### **application.yml**
```yml
spring:
  application:
    name: spring-cloud-producer

eureka:
  client:
    service-url:
      defaultZone: http://localhost:40001/eureka/
server:
  port: 8080
```

## Eureka Consumer
### **application.yml**
```yml
spring:
  application:
    name: cloud-consumer

eureka:
  client:
    service-url:
      defaultZone: http://localhost:40001/eureka/
server:
  port: 9099
```

使用 `@FeignClient` 远程调用 **spring-cloud-producer** 服务的接口，需要添加 `org.springframework.cloud:spring-cloud-starter-openfeign` 依赖，然后在 Controller 中调用 FeignClient 接口的方法请求其他服务
```java
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Component
@FeignClient(name= "spring-cloud-producer")
public interface HelloRemote {
  @GetMapping(value = "/hello")
  public String hello(@RequestParam(value = "word") String name);
}
```



### 修改本机的域名映射
> ‪C:\Windows\System32\drivers\etc\hosts




# Link
### Spring Offical
#### get start：service-registration-and-discovery
https://spring.io/guides/gs/service-registration-and-discovery/

### Video
#### 尚硅谷
https://www.bilibili.com/video/av42199337

### Blog
#### 纯洁的微笑
http://www.ityouknow.com/spring-cloud.html
#### Martin Fowler
https://martinfowler.com/articles/microservices.html
