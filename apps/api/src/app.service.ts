import { Injectable } from '@nestjs/common';
import {
  ClientProxyFactory,
  Transport,
  ClientProxy,
} from '@nestjs/microservices';

@Injectable()
export class AppService {
  private clientKeys: ClientProxy;
  private clientValues: ClientProxy;

  constructor() {
    this.clientKeys = ClientProxyFactory.create({
      transport: Transport.TCP,
      options: {
        host: process.env.SERVICE_KEYS_HOST || '127.0.0.1',
        port: process.env.SERVICE_KEYS_PORT
          ? parseInt(process.env.SERVICE_KEYS_PORT ?? '')
          : 4001,
      },
    });

    this.clientValues = ClientProxyFactory.create({
      transport: Transport.TCP,
      options: {
        host: process.env.SERVICE_VALUES_HOST ?? '127.0.0.1',
        port: process.env.SERVICE_VALUES_PORT
          ? parseInt(process.env.SERVICE_VALUES_PORT ?? '')
          : 4002,
      },
    });
  }

  public async getHello(name: string): Promise<string> {
    const key = await this.clientKeys
      .send<string, string>('get-hello-key', '')
      .toPromise();

    const value = await this.clientValues
      .send<string, string>('get-hello-value', name)
      .toPromise();

    return `${key} ${value}`;
  }
}
