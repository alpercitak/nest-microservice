import { Test, TestingModule } from '@nestjs/testing';
import { SvcKeysController } from './app.controller';
import { SvcKeysService } from './app.service';

describe('SvcKeysController', () => {
  let svcKeysController: SvcKeysController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [SvcKeysController],
      providers: [SvcKeysService],
    }).compile();

    svcKeysController = app.get<SvcKeysController>(SvcKeysController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(svcKeysController.getHello()).toBe('Hello World!');
    });
  });
});
