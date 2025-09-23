import router from '@ohos.router';

// 定义角色接口
interface Character {
  name: string;
  color: string;
}

// 定义对话项接口
interface DialogueItem {
  role?: Character;
  narrator?: boolean;
  text?: string;
  image?: string;
  background?: string;
  sound?: string;
  imagePosition?: 'left' | 'center' | 'right'; // 添加图片位置属性
}

@Component
struct CharacterDialog {
  @Prop name: string = '';
  @Prop text: string = '';
  @Prop image: string = '';
  @Prop isNvl: boolean = false;
  @Prop imagePosition: 'left' | 'center' | 'right' = 'left'; // 添加图片位置属性

  build() {
    if (this.isNvl) {
      // NVL模式对话框
      Row() {
        if (this.image !== '') {
          Image($rawfile(this.image))
            .width(160)
            .height(160)
            .borderRadius(80)
            .margin({ right: 16 })
        }
        Column() {
          if (this.name !== '') {
            Text(this.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#c8c8ff')
          }
          Text(this.text)
            .fontSize(24)
            .maxLines(3)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#00000080')
    } else {
      // ADV模式对话框 - 支持图片位置
      Column() {
        if (this.image !== '') {
          Row() {
            // 根据图片位置添加空白填充
            if (this.imagePosition === 'center') {
              Blank()
                .layoutWeight(1)
            } else if (this.imagePosition === 'right') {
              Blank()
                .layoutWeight(1)
            }
            
            Image($rawfile(this.image))
              .width(200)
              .height(200)
              .borderRadius(100)
            
            if (this.imagePosition === 'center') {
              Blank()
                .layoutWeight(1)
            } else if (this.imagePosition === 'left') {
              Blank()
                .layoutWeight(1)
            }
          }
          .width('100%')
          .margin({ bottom: 16 })
        }
        if (this.name !== '') {
          Text(this.name)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#c8c8ff')
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 8 })
        }
        Text(this.text)
          .fontSize(28)
          .maxLines(4)
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#00000080')
    }
  }
}

@Entry
@Component
struct GalgamePage {
  // 角色定义
  private role1: Character = { name: '憂鬱生鱼片', color: '#c8c8ff' };
  private role2: Character = { name: '服务员', color: '#c8c8ff' };
  private role3: Character = { name: '杨辰', color: '#c8c8ff' };
  private role4: Character = { name: '大龙', color: '#c8c8ff' };
  private role5: Character = { name: '老吕', color: '#c8c8ff' };

  // 场景背景
  @State currentBackground: string = 'rawfile/images/bg1.jpg';
  @State currentName: string = '';
  @State currentText: string = '点击屏幕开始游戏';
  @State currentImage: string = '';
  @State isNvlMode: boolean = false;

  // 游戏状态
  @State currentStep: number = 0;
  @State gameEnded: boolean = false;

    // 对话内容
  private dialogues: DialogueItem[] = [
    { role: this.role1, text: '我不太明白为什么这种答辩半成品都有人要()' },
    { role: this.role1, text: '既然如此，求求关注b站憂鬱生鱼片喵！关注b站憂鬱生鱼片谢谢喵！！（憂鬱是忧郁的繁体）' },
    { narrator: true, text: '弗雷尔卓德的冬夜常是如此' },
    { narrator: true, text: '天空像是块被搓灰的毛玻璃' },
    { narrator: true, text: '钝刀子般的寒风呼啸不停，吹得我脸生疼' },
    { narrator: true, text: '靴底踩碎地上零星的白霜，发出刺耳的"嘎吱"声' },
    { narrator: true, text: '恐怕这就是这死寂冬夜里唯一的节奏' },
    { narrator: true, text: '忽然，鼻尖触及一点冰凉' },
    { narrator: true, text: '抬头望去，沉默的天幕撕开了口子，鹅毛大雪砸了下来' },
    { narrator: true, text: '啊啊，又下雪了啊' },
    { narrator: true, text: '正当我这样想着的时候，自己的身体已经开始止不住的颤抖' },
    { narrator: true, text: '远处有一道光......' },
    { narrator: true, text: '那是一家......饭店吗' },
    { narrator: true, text: '我向老吕使了个眼色，我们加快了脚步' },
    // 背景切换到bg2
    { background: 'rawfile/images/bg2.jpg' },
    { role: this.role2, text: '里面请，哥', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '来点什么？', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role3, text: '我看看菜单哈', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '老实说，我不是很饿', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '但是我实在是受不了外边的严寒了', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '或许是我年龄大了吧', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '这么想的时候，我注意到服务员还站在我的旁边，似乎是在等我点餐', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '我迅速浏览了一遍菜单，选了几个看起来还不错的菜', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '他们的旁边都有一个大大的红色大拇指，写着"店长推荐"', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '对了，必须得来点小酒', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role3, text: '今天应该性情一下了', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '（我点了单）' },
    { narrator: true, text: '这里真是好温暖啊，相比外边，简直是天堂' },
    { narrator: true, text: '这时我注意到店内其实只有两桌人', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'center' },
    { narrator: true, text: '另一桌似乎只有一个人', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'center' },
    { narrator: true, text: '那位大哥身着朴素，看起来和我年龄相仿', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'center' },
    { narrator: true, text: '过了一阵子，我们的菜上来了' },
    { role: this.role3, text: '老吕啊，今天咱俩必须好好喝点！', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'center' },
    { sound: 'audio/yeah.mp3' },
    { narrator: true, text: '我拿起瓶起子，十分潇洒地起了瓶盖' },
    { narrator: true, text: '准备倒酒时，发现瓶盖不知去向了' },
    { narrator: true, text: '算了，这个不重要' },
    { narrator: true, text: '就在这是，我听到了一声大喊......' },
    { role: this.role4, text: '哥们你挺der啊！！', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { role: this.role4, text: '这饭店就你自己吃饭啊？！', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { narrator: true, text: '我转过头，发现隔壁桌的大哥怒目圆睁，死死盯着我的眼睛', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { narrator: true, text: '我测，瓶盖崩他身上了', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { narrator: true, text: '慌乱中我赶紧站起身', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { role: this.role3, text: '哎妈兄弟，实在不好意思', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { narrator: true, text: '我能感觉到我的脸在烧', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { role: this.role3, text: '这样，我叫服务员给你换一桌', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { role: this.role3, text: '服务员----', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { narrator: true, text: '我被他打断了', image: 'rawfile/images/微信图片_20250904202705_358_18.png', imagePosition: 'center' },
    { role: this.role4, text: '欸，都叫兄弟了那还说啥了', image: 'rawfile/images/微信图片_20250904202708_361_18.png', imagePosition: 'center' },
    { role: this.role4, text: '我把自己挖出来不就完了', image: 'rawfile/images/微信图片_20250904202708_361_18.png', imagePosition: 'center' },
    { role: this.role4, text: '行了，回去吃饭吧，别影响心情奥', image: 'rawfile/images/微信图片_20250904202708_361_18.png', imagePosition: 'center' },
    { narrator: true, text: '我去，吓死我了' },
    { narrator: true, text: '不过他人真好啊......' },
    { narrator: true, text: '......' },
    { role: this.role3, text: '现在该窃听风云了', image: 'rawfile/images/微信图片_20250904202712_364_18.png', imagePosition: 'right' },
    { role: this.role4, text: '服务员，你这里有烟吗', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { role: this.role2, text: '没有，哥', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { role: this.role4, text: '你给我买一盒呗', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { role: this.role2, text: '我店里太忙，走不开哥', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { role: this.role4, text: '那好吧', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { role: this.role3, text: '老吕，你去后备箱拿两盒烟过来', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'right' },
    { narrator: true, text: '老吕去拿了烟' },
    { narrator: true, text: '......' },
    { narrator: true, text: '他把烟递给了我' },
    { narrator: true, text: '我一定要好好表达我的歉意口牙！！' },
    { role: this.role3, text: '哎兄弟，我后备箱正好有烟，你拿着抽', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'left' },
    { role: this.role4, text: '你这太性情了哥们', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'left' },
    { role: this.role3, text: '哎刚才瓶盖崩你脑门上了，哎，我太不好意思', image: 'rawfile/images/微信图片_20250904202710_363_18.png', imagePosition: 'left' },
    { role: this.role4, text: '哎', image: 'rawfile/images/微信图片_20250904202713_365_18.png', imagePosition: 'center' },
    { role: this.role3, text: '咱都老爷们没那么多事，你拿着抽', image: 'rawfile/images/微信图片_20250904202713_365_18.png', imagePosition: 'center' },
    { narrator: true, text: '坐下之后，我和老吕继续吃饭' },
    { narrator: true, text: '我隐约听见一句"这扯不扯"' },
    { narrator: true, text: '哎，说实话，我好高兴' },
    { narrator: true, text: '.......' },
    { role: this.role4, text: '哎，兄弟', image: 'rawfile/images/微信图片_20250904202713_365_18.png', imagePosition: 'center' },
    { role: this.role4, text: '我吃完了，先走了奥', image: 'rawfile/images/微信图片_20250904202713_365_18.png', imagePosition: 'center' },
    { narrator: true, text: '他拍了拍我送的烟盒，对我笑了笑', image: 'rawfile/images/微信图片_20250904202713_365_18.png', imagePosition: 'center' },
    { narrator: true, text: '过了一段时间......' },
    { narrator: true, text: '该结账了，虽然外边很冷' },
    { narrator: true, text: '但是我早晚要面对啊' },
    { role: this.role3, text: '服务员，买单', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role2, text: '已经买过了哥', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role3, text: '买过了？？老吕你买的？', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role5, text: '没啊', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role3, text: '那是谁买的？？', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role2, text: '后面那桌给你结的', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { role: this.role3, text: '哎我，你说这扯不扯', image: 'rawfile/images/微信图片_20250904202715_366_18.png', imagePosition: 'center' },
    { narrator: true, text: '我匆忙向外跑，只为寻到他的身影' },
    // 背景切换
    { background: 'rawfile/images/bg3.png' },
    { narrator: true, text: '......' },
    { background: 'rawfile/images/bg1.jpg' },
    { role: this.role3, text: '兄弟！！！', image: 'rawfile/images/微信图片_20250904203856_367_18.png', imagePosition: 'center' },
    { narrator: true, text: '提着昨日种种千辛万苦......', image: 'rawfile/images/微信图片_20250904203856_367_18.png', imagePosition: 'center' },
    { narrator: true, text: '向明天换一些美满和幸福', image: 'rawfile/images/微信图片_20250904203857_368_18.png', imagePosition: 'center' },
    { narrator: true, text: '貂蝉在一起了。' },
    { narrator: true, text: 'END' }
  ];

  aboutToAppear() {
    // 初始化游戏
  }

  playNextDialogue() {
    if (this.currentStep >= this.dialogues.length) {
      this.gameEnded = true;
      this.currentText = 'END - 点击返回主菜单';
      return;
    }

    const dialogue = this.dialogues[this.currentStep];
    
    // 处理背景切换
    if (dialogue.background) {
      this.currentBackground = dialogue.background;
    }
    
    // 处理角色对话
    if (dialogue.role) {
      this.currentName = dialogue.role.name;
      this.currentText = dialogue.text || '';
      this.currentImage = dialogue.image || '';
      this.isNvlMode = false;
    }
    
    // 处理叙述者
    if (dialogue.narrator) {
      this.currentName = '';
      this.currentText = dialogue.text || '';
      this.currentImage = dialogue.image || '';
      this.isNvlMode = false;
    }
    
    this.currentStep++;
  }

  onScreenTap() {
    if (!this.gameEnded) {
      this.playNextDialogue();
    } else {
      // 游戏结束，返回主菜单
      router.pushUrl({ url: 'pages/Index' });
    }
  }

  build() {
    Stack() {
      // 背景图片
      Image($rawfile(this.currentBackground))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 对话框
      Column() {
        Blank()
          .layoutWeight(1)
        
        // 显示对话内容
        CharacterDialog({
          name: this.currentName,
          text: this.currentText,
          image: this.currentImage,
          isNvl: this.isNvlMode,
          imagePosition: this.dialogues[this.currentStep - 1]?.imagePosition || 'left'
        })
        
        // 点击提示
        Text('点击屏幕继续')
          .fontSize(20)
          .fontColor('#ffffff80')
          .alignSelf(ItemAlign.End)
          .margin({ right: 32, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .onClick(() => {
        this.onScreenTap();
      })
    }
    .width('100%')
    .height('100%')
  }
}
