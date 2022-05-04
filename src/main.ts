import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerCustomOptions, SwaggerDocumentOptions, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('/api/v0')
  app.useGlobalPipes(new ValidationPipe())

  const docsConfig = new DocumentBuilder()
  .setTitle('Toolkit API')
  .setDescription('The API for GP Toolkit')
  .setVersion('0.1.0')
  .build();

  const docsOptions: SwaggerDocumentOptions = {
    deepScanRoutes: true
  }

  const document = SwaggerModule.createDocument(app, docsConfig, docsOptions);

  const docsCustomOptions: SwaggerCustomOptions = {
    customSiteTitle: 'Docs - toolkit api'
  }
  SwaggerModule.setup('', app, document, docsCustomOptions);

  await app.listen(3000);
}
bootstrap();
