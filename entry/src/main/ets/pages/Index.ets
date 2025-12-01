import Constants from '../common/constants/Constants';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode, ColorMetrics } from '@kit.ArkUI';

@Entry
@Component
export struct VerificationWindowPage {

  @State isInputWrong: boolean = false;
  @State inputText: string = '';
  private imageId: number = 0;
  @State isPressed: boolean = false;
  @State boxValues: string[] = ['', '', '', ''];

  build() {
    Scroll() {
      Column() {

        Text("Please enter the code")
          .width('90%')
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .padding({ top: 50, bottom: 5 })

        Row({ space: 8 }) {
          ForEach(this.boxValues, (value: string, index: number) => {
            Box({ value: value })
              .margin(5)
          })
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceAround)

        TextInput({ text: this.inputText })
          .onChange((value: string) => {
            this.inputText = value;
            this.updateBoxValues(value);
          })
          .enablePreviewText(false)
          .maxLength(4)
          .fontColor(Color.Transparent)
          .backgroundColor(Color.Transparent)
          .width(0)
          .height(0)
          .opacity(0)
          .defaultFocus(true)
          .focusOnTouch(true)
          .caretColor(Color.Transparent)

        if (this.inputText.length !== 4 && this.isPressed) {
          Row({ space: 5 }) {
            Image($r('app.media.error'))
              .width(16)
              .height(16)
              .padding(2)
              .fillColor(Color.Red)

            Text("Please fill the area")
              .fontSize(12)
              .fontColor(Color.Red)
              .fontWeight(FontWeight.Medium)
          }
          .margin({ top: 10 })
        }

        ArcButton({
          options: new ArcButtonOptions({
            label: 'Verify',
            position: ArcButtonPosition.BOTTOM_EDGE,
            styleMode: ArcButtonStyleMode.CUSTOM,
            backgroundColor: ColorMetrics.resourceColor($r('app.color.button')),
            onClick: () => {
              this.isPressed = true
              if (this.inputText.length === 4) {

              } else {
                this.isInputWrong = true;
              }
            }
          })
        })
          .margin({top:30})
          .width('%100')
      }
      .width('100%')
      .backgroundColor(Color.White)
      .alignItems(HorizontalAlign.Center)
      .borderRadius($r('app.float.verify_ok_margin'))
    }
    .height(Constants.FULL_PARENT)
    .width(Constants.FULL_PARENT)
    .backgroundColor(Color.White)
  }

  updateBoxValues(input: string) {
    let newBoxValues: string[] = ['', '', '', ''];
    for (let i = 0; i < 4; i++) {
      newBoxValues[i] = input[i] || '';
    }
    this.boxValues = newBoxValues;
  }
}

@Component
export struct Box {
  @Prop value: string;

  build() {
    Text(this.value.toUpperCase())
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
      .width(40)
      .height(40)
      .borderRadius(8)
      .fontColor(Color.Black)
      .border({ width: 1.5, color: Color.Gray, radius: 8 })
      .backgroundColor('#F0F0F0')
  }
}