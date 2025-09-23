import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      // 背景图片
      Image($rawfile('gui/111.jpg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 居中内容
      Column() {
        Text(this.message)
          .id('HelloWorld')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Welcome';
          })
          .margin({ bottom: 32 })
        Button('开始游戏')
          .width(200)
          .height(60)
          .fontSize(24)
          .onClick(() => {
            // 跳转到Galgame页面
            router.pushUrl({ url: 'pages/GalgamePage' });
          })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
