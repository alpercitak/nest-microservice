import { Controller, Get, Query } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  async getHello(@Query() query: any): Promise<string> {
    const helloValue = await this.appService.getHello(query.name || '');
    return helloValue;
  }
}
