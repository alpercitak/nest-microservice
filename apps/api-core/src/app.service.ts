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
        host: 'svc-keys',
        port: 4001,
      },
    });

    this.clientValues = ClientProxyFactory.create({
      transport: Transport.TCP,
      options: {
        host: 'svc-values',
        port: 4002,
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
