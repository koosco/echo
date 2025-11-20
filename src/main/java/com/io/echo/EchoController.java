package com.io.echo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class EchoController {

  private static final Logger logger = LoggerFactory.getLogger(EchoController.class);

  @GetMapping
  public String echo() {
    logger.info("Echo API request received");
    return "Hello, World!";
  }
}
