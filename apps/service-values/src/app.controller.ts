import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { AppService } from './app.service';
import { MessagePatternKeys } from '@nest-microservice/lib';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern(MessagePatternKeys.GetHelloValue)
  getHello(name: string): string {
    return this.appService.getHello(name);
  }
}
