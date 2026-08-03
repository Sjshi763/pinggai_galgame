import router from '@ohos.router';
import resourceManager from '@ohos.resourceManager';
import util from '@ohos.util';

// 定义角色接口
interface Character {
  id: string;
  name: string;
  color: string;
}

// 定义对话项接口
interface DialogueItem {
  roleId?: string;
  narrator?: boolean;
  text?: string;
  image?: string;
  background?: string;
  sound?: string;
  bgm?: string;
  stopBgm?: boolean;
  imagePosition?: 'left' | 'center' | 'right';
}

// 定义游戏数据接口
interface GameData {
  characters: Character[];
  dialogues: DialogueItem[];
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
  // 游戏数据
  @State gameData: GameData = { characters: [], dialogues: [] };
  @State dataLoaded: boolean = false;
  
  // 角色映射表
  private characterMap: Map<string, Character> = new Map();

  // 场景背景
  @State currentBackground: string = 'images/bg1.jpg';
  @State currentName: string = '';
  @State currentText: string = '点击屏幕开始游戏';
  @State currentImage: string = '';
  @State isNvlMode: boolean = false;
  @State currentPosition: 'left' | 'center' | 'right' = 'left';

  // 游戏状态
  @State currentStep: number = 0;
  @State gameEnded: boolean = false;

  aboutToAppear() {
    // 初始化游戏 - 加载JSON数据
    this.loadGameData();
  }
  
  async loadGameData() {
    try {
      // 获取资源管理器
      const context = getContext(this);
      const resMgr = context.resourceManager;
      
      // 读取rawfile中的dialogues.json
      const fileData = await resMgr.getRawFileContent('dialogues.json');
      
      // 将Uint8Array转换为字符串
      const decoder = new util.TextDecoder('utf-8');
      const jsonString = decoder.decodeToString(fileData);
      
      // 解析JSON
      const data: GameData = JSON.parse(jsonString);
      
      // 构建角色映射表
      data.characters.forEach(char => {
        this.characterMap.set(char.id, char);
      });
      
      // 保存游戏数据
      this.gameData = data;
      this.dataLoaded = true;
      
      console.info('Game data loaded successfully');
    } catch (error) {
      console.error('Failed to load game data:', error);
      this.currentText = '加载数据失败，请重试';
    }
  }

  playNextDialogue() {
    if (!this.dataLoaded || this.currentStep >= this.gameData.dialogues.length) {
      this.gameEnded = true;
      this.currentText = 'END - 点击返回主菜单';
      return;
    }

    const dialogue = this.gameData.dialogues[this.currentStep];
    
    // 处理背景切换
    if (dialogue.background) {
      this.currentBackground = dialogue.background;
    }
    
    // 处理角色对话
    if (dialogue.roleId) {
      const character = this.characterMap.get(dialogue.roleId);
      if (character) {
        this.currentName = character.name;
      }
      this.currentText = dialogue.text || '';
      this.currentImage = dialogue.image || '';
      this.currentPosition = dialogue.imagePosition || 'left';
      this.isNvlMode = false;
    }
    
    // 处理叙述者
    if (dialogue.narrator) {
      this.currentName = '';
      this.currentText = dialogue.text || '';
      this.currentImage = dialogue.image || '';
      this.currentPosition = dialogue.imagePosition || 'left';
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
          imagePosition: this.currentPosition
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
