import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHelloKey(): string {
    return `${new Date().toUTCString()} - Hello`;
  }
}
