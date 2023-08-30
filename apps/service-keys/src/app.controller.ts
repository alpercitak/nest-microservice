import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { AppService } from './app.service';
import { MessagePatternKeys } from '@nest-microservice/lib';
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern(MessagePatternKeys.GetHelloKey)
  getHelloKey(): string {
    return this.appService.getHelloKey();
  }
}
