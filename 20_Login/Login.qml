import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0

import "qrc:/ConfiguracoesFormScripts.js" as Calljava

Item {
    anchors.fill:parent

    property StackView settingsStack

    Component.onCompleted: currentPage='B'
    Component.onDestruction:currentPage='A'

    Rectangle{
        id:config_contas_fixas
        anchors.fill:parent
        color: 'transparent'
        TextField{
            id: field_nome_conta
            transformOrigin: Item.Center
            text:qsTr("Nome da conta")
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                bottomMargin: parent.height*0.92
                leftMargin: parent.width*0.02
                rightMargin: (parent.width*0.5)+2.5
            }
            onPressed: {
                field_nome_conta.clear()
            }
        }
        ComboBox {
            id: combobox_categoria_conta_config
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                bottomMargin: parent.height*0.92
                leftMargin: (parent.width*0.5)+2.5
                rightMargin: parent.width*0.02
            }
            model:["Alimentação","Carro","Casa","Compras","Doações","Essencial","Estudo","Financiamento","Investimento","Lazer","Obras","Saúde"]
        }
        TextField {
            id: field_valor
            text:qsTr("Valor da conta")
            height: field_nome_conta.height
            anchors{
                top: field_nome_conta.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: (parent.width*0.5)+2.5
            }
            onPressed: {
                field_valor.clear()
            }
        }
        ComboBox {
            id: config_combobox_acompanhamento
            height: field_nome_conta.height
            anchors{
                top: field_nome_conta.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: (parent.width*0.5)+2.5
                rightMargin: parent.width*0.02
            }
        }
        ComboBox {
            id: config_contas_combobox_debito
            height: field_nome_conta.height
            anchors{
                top: field_valor.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: (parent.width*0.5)+2.5
            }
        }
        ComboBox {
            id: field_vencimento
            height: field_nome_conta.height
            anchors{
                top: config_combobox_acompanhamento.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: (parent.width*0.5)+2.5
                rightMargin: parent.width*0.02
            }
            model:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
        }
        Rectangle{
            id:checkbox_rec
            height: field_nome_conta.height
            color: "#00000000"
            anchors{
                top: field_vencimento.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            CheckBox {
                id: checkbox_auto
                text: qsTr("Auto")
                checkable: true
                tristate: false
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: parent.height*0.02
                    bottomMargin: parent.height*0.02
                    leftMargin: parent.width*0.02
                    rightMargin: (parent.width*0.5)+2.5
                }
            }
            CheckBox {
                id: checkBox_irpf
                text: qsTr("IRPF")
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: parent.height*0.02
                    bottomMargin: parent.height*0.02
                    leftMargin: (parent.width*0.5)+2.5
                    rightMargin: parent.width*0.02
                }
            }
        }
        Button {
            id: config_contas_button_cadastrar
            height: field_nome_conta.height * 1.2
            text: qsTr("CADASTRAR")
            anchors{
                top: checkbox_rec.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onClicked: {
                config_contas_button_cadastrar.text= "Conta " + field_nome_conta.text + ' adicionada'
//                timer_botao.start()
//                Calljava.f02_cadastrar_contafixa()

                billObj.name=field_nome_conta.text
                billObj.expire=field_vencimento.currentText
                billObj.bank=config_contas_combobox_debito.currentText
                if(checkbox_auto.checkState===2)billObj.auto=true
                else billObj.auto=false
                billObj.value=field_valor.text
                billObj.status=_LIB_CONST._billsOpenStatus
                billObj.category=combobox_categoria_conta_config.currentText
                if(config_combobox_acompanhamento.currentIndex===0)billObj.link=emptyField
                else billObj.link=config_combobox_acompanhamento.currentIndex
                if(checkBox_irpf.checkState===2)billObj.tax=true
                else billObj.tax=false
                billObj.nextValue=emptyField

                __BILLS_HANDLER.recordNewBill(billObj.exportValue)

                //                        label_status.text = ""
                //                        JSDatabase.i019_configuracoes_cadastrar_contafixa_button()
                //                        label_status.text="Conta " + field_nome_conta.text + ' adicionada'
            }
        }
        Rectangle{
            id:separador1
            color:"black"
            height: field_nome_conta.height*0.1
            anchors{
                top: config_contas_button_cadastrar.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
        }
        ComboBox {
            id: combobox_alterar_contafixa
            height: field_nome_conta.height
            anchors{
                top: separador1.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onCurrentIndexChanged: {
                Calljava.f03_selecionar_contafixa()
            }
        }
        TextField {
            id: field_novovalor
            text: qsTr("NOVO VALOR")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            height: field_nome_conta.height
            anchors{
                top: combobox_alterar_contafixa.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onPressed: {
                field_novovalor.clear()
            }
        }
        TextField {
            id: field_novovencimento
            text: qsTr("NOVA DATA DE VENCIMENTO")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            height: field_nome_conta.height
            anchors{
                top: field_novovalor.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onPressed: {
                field_novovencimento.clear()
            }
        }
        Button {
            id: button_alterar
            text: qsTr("ALTERAR")
            height: field_nome_conta.height * 1.2
            anchors{
                top: field_novovencimento.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onClicked: {
                button_alterar.text=combobox_alterar_contafixa.currentText
                        + " alterado para R$ " + field_novovalor.text
                        + " e vencimento dia " + field_novovencimento.text
                timer_botao.start()
                Calljava.f05_alterar_valor_contafixa()
            }
        }
        Button {
            id: button_remover
            text: qsTr("REMOVER")
            height: field_nome_conta.height * 1.2
            anchors{
                top: button_alterar.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.height*0.02
                leftMargin: parent.width*0.02
                rightMargin: parent.width*0.02
            }
            onClicked: {
                button_remover.text="Conta "+ combobox_alterar_contafixa.currentText
                        + " removida"
                timer_botao.start()
                Calljava.f06_remover_contafixa()


            }
        }

}
}
