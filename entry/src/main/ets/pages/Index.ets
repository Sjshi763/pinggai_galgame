@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Image($rawfile('gui/111.jpg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .position({ x: 0, y: 0 })
        .zIndex(0)
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
        .zIndex(1)
    }
    .height('100%')
    .width('100%')
  }
}