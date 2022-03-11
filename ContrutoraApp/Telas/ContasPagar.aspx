﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContasPagar.aspx.cs" Inherits="ContrutoraApp.ContasPagar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>

    <title></title>

    <style type="text/css">
        #tbDados tr tr:hover {
            background-color: aquamarine;
        }
    </style>
</head>

<script type="text/javascript" language="javascript">

    $(document).ready(function () {

        TabelaLancarDados();
        /*  Menu();*/

    });

    const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
            confirmButton: 'btn btn-success',
            cancelButton: 'btn btn-danger'
        },
        buttonsStyling: false
    });

    function validateDate(id) {
        if (id.value != '') {
            var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;

            if (!((id.value.match(RegExPattern)) && (id.value != ''))) {
                swalWithBootstrapButtons.fire({
                    title: '',
                    text: 'Data inválida! Digite novamente no formato DD/MM/AAAA.',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                });
                id.value = "";
                id.focus();
            }
            else {
                var dataPrazo = $('#hdnDataPrazoCalculado').val();
                var dt_prazo = dataPrazo;
                dataPrazo = dataPrazo.split('/')[2] + dataPrazo.split('/')[1] + dataPrazo.split('/')[0];

                var dataDigitada = $('#txtData').val();
                dataDigitada = dataDigitada.split('/')[2] + dataDigitada.split('/')[1] + dataDigitada.split('/')[0];

                if (parseInt(dataDigitada) < parseInt(dataPrazo)) {
                    swalWithBootstrapButtons.fire({
                        title: '',
                        text: 'Data programada não pode ser menor que a data de prazo ' + dt_prazo + '!',
                        icon: 'error',
                        confirmButtonText: 'OK',
                        allowOutsideClick: false
                    });
                    id.value = "";
                    id.focus();
                }
            }
        }
    }

    function verBackSpace(v, n) {
        var tecla = event.keyCode;
        if (n == data && tecla == 8 && (v.value.length == 7 || v.value.length == 4)) {
            var texto = v.value.substring(0, v.value.length - 1);
            v.value = texto;
        }
    }

    function mascaraMutuario(o, f) {
        v_obj = o
        v_fun = f
        setTimeout('execmascara()', 1)
    }

    function execmascara() {
        v_obj.value = v_fun(v_obj.value)
    }

    function data(v) {

        //Remove tudo o que não é dígito
        v = v.replace(/\D/g, "")

        //Coloca uma barra entre o segundo e o terceiro dígitos
        v = v.replace(/(\d{2})(\d)/, "$1/$2")

        //Coloca uma barra entre o segundo e o terceiro dígitos
        //de novo (para o segundo bloco de números)
        v = v.replace(/(\d{2})(\d)/, "$1/$2")

        return v

    }

    function validateDate(id) {
        if (id.value != '') {
            var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;

            if (!((id.value.match(RegExPattern)) && (id.value != ''))) {
                swalWithBootstrapButtons.fire({
                    title: '',
                    text: 'Data inválida! Digite novamente no formato DD/MM/AAAA.',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                });
                id.value = "";
                id.focus();
            }
            else {
                var dataPrazo = $('#hdnDataPrazoCalculado').val();
                var dt_prazo = dataPrazo;
                dataPrazo = dataPrazo.split('/')[2] + dataPrazo.split('/')[1] + dataPrazo.split('/')[0];

                var dataDigitada = $('#txtData').val();
                dataDigitada = dataDigitada.split('/')[2] + dataDigitada.split('/')[1] + dataDigitada.split('/')[0];

                if (parseInt(dataDigitada) < parseInt(dataPrazo)) {
                    swalWithBootstrapButtons.fire({
                        title: '',
                        text: 'Data programada não pode ser menor que a data de prazo ' + dt_prazo + '!',
                        icon: 'error',
                        confirmButtonText: 'OK',
                        allowOutsideClick: false
                    });
                    id.value = "";
                    id.focus();
                }
            }
        }
    }

    //function Menu() {


    //    $.ajax({
    //        type: "POST",
    //        url: "ContasPagar.aspx/Menu",
    //        data: "{'m':'m'}",
    //        contentType: "application/json; charset=utf-8",
    //        dataType: "JSON",
    //        success: function (data) {
    //            var source = data.d;
    //            $('#menu').html(source);



    //        },
    //        error: function (request, status, error) {
    //            alert(request.responseText);
    //            console.log(request.responseText);
    //            //swalWithBootstrapButtons.fire({
    //            //    title: '',
    //            //    text: 'Erro ao abrir tabela! Tente novamente!',
    //            //    icon: 'error',
    //            //    confirmButtonText: 'OK',
    //            //    allowOutsideClick: false
    //            //}).then((result) => {
    //            /*  });*/
    //        }
    //    });

    //}

    function TabelaLancarDados() {



        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/TabelaContasPagar",
            data: "{'':''}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                $('#div').html(source);

            },
            error: function (request, status, error) {
                alert(request.responseText);
                console.log(request.responseText);
                //swalWithBootstrapButtons.fire({
                //    title: '',
                //    text: 'Erro ao abrir tabela! Tente novamente!',
                //    icon: 'error',
                //    confirmButtonText: 'OK',
                //    allowOutsideClick: false
                //}).then((result) => {
                /*  });*/
            }
        });

    }

    function GravarConta() {

        var desc_conta = $('#txtConta').val();
        var tipo = $('#ddlTipo').val();
        var num_parcela_string = $('#txtParcela').val();
        var valor_string = $('#txtValor').val().trim().replace('.', '').replace(',', '.');
        var tp_despesa = $('#ddlTipodespesa').val();
        var data = $('#txtData').val().trim().split('/')[0] + '/' + $('#txtData').val().trim().split('/')[1] + '/' + $('#txtData').val().trim().split('/')[2] + ' 23:59:59';
        var desc_despesa = '';
        var id_obra = 0;
        if ($('#txtDespesa').val() != '') {
            desc_despesa = $('#txtDespesa').val();
        }
        if ($('#ddlObra').val() != '') {
            id_obra = $('#ddlObra').val();
        }


        var Contas = {
            desc_conta: desc_conta,
            tipo: tipo,
            num_parcela_string: num_parcela_string,
            valor_string: valor_string,
            data: data,
            desc_despesa: desc_despesa,
            id_obra: id_obra
        };

        var obj = { 'Contas': Contas };

        console.log(obj);

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/Gravar",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                if (source == "OK") {
                    alertCss('Gravar');
                    lancarDados();

                }


            },
            error: function (request, status, error) {
                alert(request.responseText);
                console.log(request.responseText);
                //swalWithBootstrapButtons.fire({
                //    title: '',
                //    text: 'Erro ao abrir tabela! Tente novamente!',
                //    icon: 'error',
                //    confirmButtonText: 'OK',
                //    allowOutsideClick: false
                //}).then((result) => {
                /*  });*/
            }
        });

    }

    function detalhar(id) {

        $('#hdnIDContasPagar').val(id);
        GravarDetahesTemp('buscar');
        $('#ModalDetalhes').modal('show');
        /* $("#ModalDetalhes").modal({ show: true });*/
    }

    function fecharModal() {
        $("#ModalDetalhes").modal('hide');
        $('#txtDescDetalhes').val('');
        $('#txtQtdeDetalhes').val('');
        $('#txtvalorDetalhes').val('');
        $('#hdnIDContasPagar').val('');
        $('#tbDetalhados').html('');



        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/DeletarTabelaTempDetalhes",
            data: "{'':''}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {



            },
            error: function (request, status, error) {
                alert(request.responseText);
                console.log(request.responseText);
                //swalWithBootstrapButtons.fire({
                //    title: '',
                //    text: 'Erro ao abrir tabela! Tente novamente!',
                //    icon: 'error',
                //    confirmButtonText: 'OK',
                //    allowOutsideClick: false
                //}).then((result) => {
                /*  });*/
            }
        });
        /* $('#btnGravar').prop('disabled', '');*/
    }

    function GravarDetahesTemp(acao) {


        var Contas = {};


        if (acao == '') {


            var desc_detalhe = $('#txtDescDetalhes').val();
            var qtde = $('#txtQtdeDetalhes').val();
            var valor = $('#txtvalorDetalhes').val().trim().replace('.', '').replace(',', '.');
            var id_obra = $('#hdnIDContasPagar').val();


            Contas = {
                desc_conta: desc_detalhe,
                num_parcela: qtde,
                valor: valor,
                id_obra: id_obra
            };

        } else {
            Contas = {
                desc_conta: 'vazio',
                id_obra: $('#hdnIDContasPagar').val()
            };
        }



        var obj = { 'Contas': Contas };


        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/GravarTempDetalhes",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {

                var dados = JSON.parse(data.d);

                BuscaTabelaDetalhesModal(dados);

            },
            error: function (request, status, error) {
                alert(request.responseText);
                console.log(request.responseText);
                //swalWithBootstrapButtons.fire({
                //    title: '',
                //    text: 'Erro ao abrir tabela! Tente novamente!',
                //    icon: 'error',
                //    confirmButtonText: 'OK',
                //    allowOutsideClick: false
                //}).then((result) => {
                /*  });*/
            }
        });

    }

    function BuscaTabelaDetalhesModal(dados) {

        var table = "";

        if (dados.listaContas1[0].desc_conta != 'vazio') {


            table += "      <table id='tbDadosModal' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            var cor_r = "#FFFFFF";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:bold'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Qtde</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'>  </th>";
            table += "          </tr> ";
        }

        if (dados.listaContas1[0].desc_conta != 'vazio') {
            $(dados.listaContas1).each(function (index, element) {
                if (cor_r == "#FFFFFF") { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th> " + element.desc_conta + " </th>";
                table += "          <th> " + element.tipo + " </th>";
                table += "          <th> " + element.valor + " </th>";

                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; cursor: pointer; text-align:center' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; cursor: pointer; text-align:center' /> </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px;  height:20px; cursor: pointer;text-align:center; padding-top:initial'   /> </th>";
                table += "          </tr> ";

            });
        }




        //if (dados.listaContas2[0].desc_conta != 'vazio') {
        //    $(dados.listaContas2).each(function (index, element) {
        //        if (cor_r == "#FFFFFF") { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
        //        table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
        //        table += "          <th> " + element.desc_conta + " </th>";
        //        table += "          <th> " + element.tipo + " </th>";
        //        table += "          <th> " + element.valor + " </th>";

        //        //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; cursor: pointer; text-align:center' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
        //        //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; cursor: pointer; text-align:center' /> </th>";
        //        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px;  height:20px; cursor: pointer;text-align:center; padding-top:initial'   /> </th>";
        //        table += "          </tr> ";

        //    });
        //}

        if (dados.listaContas1[0].desc_conta != 'vazio') {
            table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
            table += "          <th> Total </th>";
            table += "          <th>  </th>";
            table += "          <th> " + dados.listaContas1[0].valor_string + " </th>";
            table += "          <th> </th>";
            table += "          </tr> ";
        }


        $('#tbDetalhados').html(table);
    }

    function GravarDetalhes() {
        $("#ModalDetalhes").modal('hide');
        $('#txtDescDetalhes').val('');
        $('#txtQtdeDetalhes').val('');
        $('#txtvalorDetalhes').val('');



        var id_conta = $('#hdnIDContasPagar').val();

        $('#hdnIDContasPagar').val('');

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/GravarTabelaDetalhes",
            data: "{'id_conta':'" + id_conta + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                if (source == "OK") {
                    Tabeladetalhes();
                }


            },
            error: function (request, status, error) {
                alert(request.responseText);
                console.log(request.responseText);
                //swalWithBootstrapButtons.fire({
                //    title: '',
                //    text: 'Erro ao abrir tabela! Tente novamente!',
                //    icon: 'error',
                //    confirmButtonText: 'OK',
                //    allowOutsideClick: false
                //}).then((result) => {
                /*  });*/
            }
        });
    }

    function tipoDespesa(value) {

        if (value == 'Despesa') {
            $('#tdObras').addClass('hidden');
            $('#tdDespesa').removeClass('hidden');
        } else if (value == 'obra') {
            $('#tdObras').removeClass('hidden');
            $('#tdDespesa').addClass('hidden');
        } else {
            $('#tdObras').addClass('hidden');
            $('#tdDespesa').addClass('hidden');
        }
    }

    function alertCss(mensagem) {

        texto == '';
        icon == '';
        if (mensagem == ('Gravar')) {
            var texto = ('Gravado com sucesso');
            var icon = ('success');
        }
        else if (mensagem == ('Alterar')) {
            var texto = ('Alterado com Sucesso');
            var icon = ('success');
        }
        else if (mensagem == ('Cancelar')) {
            var texto = ('Cancelado com Sucesso');
            var icon = ('success');
            /*var icon = ('error');*/
        }

        swalWithBootstrapButtons.fire({
            title: '',
            text: texto,
            icon: icon,
            confirmButtonText: 'OK',
            allowOutsideClick: false
        });
    }

</script>

<style type="text/css">
    /* Estilo do alert */
    .swal2-popup {
        font-size: medium !important;
    }

    .btn {
        margin: 0 0.5rem;
        font-size: medium !important;
    }
    /*Termina aqui o style do Alert*/
</style>

<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnIDContasPagar" runat="server" />
        <div id="menu">
        </div>
        <br />
        <div>
            <center>
                <table>
                    <tr>
                        <td style="width: 100px;">
                            <asp:DropDownList ID="ddpTipoDesp" Width="120px" runat="server" CssClass="form-control" onchange="tipoDespesa(value);">
                                <asp:ListItem Text="Selecione.." Value="tipo"></asp:ListItem>
                                <asp:ListItem Text="Despesa" Value="Despesa"></asp:ListItem>
                                <asp:ListItem Text="Obra" Value="obra"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td id="tdObras" colspan="3">
                            <asp:DropDownList ID="ddlObras" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Selecione" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Obra1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Obra2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Obra3" Value="3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="txtData" Width="100px" CssClass="form-control" MaxLength="10" placeholder="__/__/____" onkeypress="mascaraMutuario(this,data);" onkeydown="verBackSpace(this,data);" onblur="validateDate(this);"></asp:TextBox>
                        </td>



                    </tr>
                    <tr class="trBody">
                        <td>
                            <asp:TextBox ID="txtConta" runat="server" Width="300px" placeholder="Conta" CssClass="form-control"></asp:TextBox>
                        </td>

                        <td>
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Forma Pgto" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Boleto" Value="BOLETO"></asp:ListItem>
                                <asp:ListItem Text="Dinheiro" Value="DINHEIRO"></asp:ListItem>
                                <asp:ListItem Text="Débito" Value="DEBITO"></asp:ListItem>
                                <asp:ListItem Text="Crédito" Value="CREDITO"></asp:ListItem>
                                <asp:ListItem Text="Cheque" Value="CHEQUE"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td>
                            <asp:TextBox ID="txtParcela" runat="server" Width="100px" placeholder="Parcela" CssClass="form-control"></asp:TextBox>
                        </td>

                        <td>
                            <asp:TextBox ID="txtValor" runat="server" placeholder="Valor" Width="100px" CssClass="form-control"></asp:TextBox>
                        </td>

                    </tr>

                    <tr>

                        <td id="tdDespesa" colspan="3">
                            <asp:TextBox ID="txtDespesa" runat="server" placeholder="Despesa" CssClass="form-control"></asp:TextBox>
                        </td>



                    </tr>
                    <tr>
                        <td id="tdFornec" colspan="3">
                            <asp:DropDownList ID="ddlFornecedor" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Selecione" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Fornec1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Fornec2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Fornec3" Value="3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="height: 20px">
                        <td style="height: 20px"></td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Gravar" OnClientClick="GravarConta();return false;" />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        <hr />

        <div style="width: 100%">
            <br />
            <center>
                <table style="width: 70%">
                    <tr>
                        <td>
                            <div id="div"></div>
                        </td>
                    </tr>
                </table>
            </center>
        </div>



        <div class="modal fade" id="ModalDetalhes" tabindex="-1" role="dialog" aria-labelledby="ModalDetalhes" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div id="modal-dialog" class="modal-dialog" role="document" style="width: 500px; max-width: 100%; max-height: 100%; height: 100%; margin: 0px auto;">
                <div id="modal-content" class="modal-content" style="width: 500px; max-width: 100%; top: 30px;">
                    <div class="modal-header">
                        <h5 class="modal-title"><b>Detalhar</b></h5>
                    </div>
                    <div id="divLiberacaoEspecial" class="modal-body" style="max-width: 100% !important; overflow-x: auto !important; height: calc(100% - 135px) !important; overflow-y: auto !important; padding: 0px 20px 20px 20px !important;">
                        <center>
                            <asp:HiddenField runat="server" ID="hdnIdLiberacao" />
                            <label id="lblLiberacaoEspecial"></label>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDescDetalhes" CssClass="form-control" Width="150px" placeholder="item"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtQtdeDetalhes" CssClass="form-control" Width="60px" placeholder="Qtde"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtvalorDetalhes" CssClass="form-control" Width="150px" placeholder="R$"></asp:TextBox>
                                    </td>
                                    <td>
                                        <input type="button" class="btn btn-info" value="Inserir" onclick="GravarDetahesTemp('')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <center>
                                            <div id="tbDetalhados">
                                            </div>
                                        </center>
                                    </td>
                                </tr>
                            </table>


                            <label id="avisoModal" style="color: red" class="hidden"><b>Selecione uma Filial</b></label>
                            <br />
                            <br />
                        </center>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btnAutorizar" style="width: 150px" class="swal2-cancel btn btn-success" onclick="GravarDetalhes();">Gravar Detalhados</button>
                        <button type="button" id="btnFechar" class="swal2-cancel btn btn-danger" onclick="fecharModal();">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
