package com.io.echo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class EchoController {

  @Value("${greeting.message}")
  private String message;

  private static final Logger logger = LoggerFactory.getLogger(EchoController.class);

  @GetMapping
  public String echo() {
    logger.info("Echo API request received");
    return "Hello, World!!";
  }

  @GetMapping("/welcome")
  public String welcome() {
    logger.info("Welcome API request received");
    return "The message is " + message;
  }
}
