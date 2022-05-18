<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContasPagar.aspx.cs" Inherits="ContrutoraApp.ContasPagar" %>

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

    function moeda(a, e, r, t) {
        let n = ""
            , h = j = 0
            , u = tamanho2 = 0
            , l = ajd2 = ""
            , o = window.Event ? t.which : t.keyCode;
        if (13 == o || 8 == o)
            return !0;
        if (n = String.fromCharCode(o),
            -1 == "0123456789".indexOf(n))
            return !1;
        for (u = a.value.length,
            h = 0; h < u && ("0" == a.value.charAt(h) || a.value.charAt(h) == r); h++)
            ;
        for (l = ""; h < u; h++)
            -1 != "0123456789".indexOf(a.value.charAt(h)) && (l += a.value.charAt(h));
        if (l += n,
            0 == (u = l.length) && (a.value = ""),
            1 == u && (a.value = "0" + r + "0" + l),
            2 == u && (a.value = "0" + r + l),
            u > 2) {
            for (ajd2 = "",
                j = 0,
                h = u - 3; h >= 0; h--)
                3 == j && (ajd2 += e,
                    j = 0),
                    ajd2 += l.charAt(h),
                    j++;
            for (a.value = "",
                tamanho2 = ajd2.length,
                h = tamanho2 - 1; h >= 0; h--)
                a.value += ajd2.charAt(h);
            a.value += r + l.substr(u - 2, u)
        }
        return !1
    }


    function TabelaLancarDados() {

        $('#btnPagas').val("Pagas");
        var status = '';
        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/TabelaContasPagar",
            data: "{'status':'" + status + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;


                $('#div').html(source);
                $('#btnPagas').prop("disabled", false);

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

    function TabelaLancarDadosPagas(status) {


        if ($('#btnPagas').val() == "Não Pagas") {

            TabelaLancarDados();

        } else {

            $('#btnPagas').prop("disabled", true);
            var status = '';

            $.ajax({
                type: "POST",
                url: "ContasPagar.aspx/TabelaContasPagas",
                data: "{'status':'" + status + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#div').html('');
                    $('#div').html(source);
                    $('#btnPagas').val("Não Pagas");
                    $('#btnPagas').prop("disabled", false);

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
        //} else {

        //    $('#btnPagas').prop("disabled", true);
        //    TabelaLancarDados('');
        //}

    }

    function GravarConta() {
        alert();
        var fornec = $('#hdnFornecedor').val();
        if (fornec == '') {
            fornec = 0;
        }

        var contaBancaria = $('#ddlConta').val();
        var desc_conta = $('#txtConta').val();
        var num_parcela_string = $('#txtParcela').val();
        var valor_string = $('#txtValor').val().trim().replace('.', '').replace(',', '.');
        var cod_despesa = $('#ddlDespesa').val();
        var data = $('#txtData').val().trim().split('/')[0] + '/' + $('#txtData').val().trim().split('/')[1] + '/' + $('#txtData').val().trim().split('/')[2];
        var obra = $('#hdnObra').val();
        var tipo_pg = $('#ddlTipoPgto').val();
        var id_conta = $('#hdnIDContasPagar').val();
        var usuario = $('#hdnUsuario').val();

        if (obra == '') {
            obra = 0;
        }

        if (id_conta == '') {
            id_conta = 0;
        }

        var Contas = {
            desc_conta: desc_conta,
            num_parcela_string: num_parcela_string,
            valor_string: valor_string,
            data: data,
            id_despesa: cod_despesa,
            id_obra: obra,
            id_fornecedor: fornec,
            tipo_pgto: tipo_pg,
            conta_bancaria: contaBancaria,
            id: id_conta,
            nm_usuario: usuario
        };

        
        var obj = { 'Contas': Contas };
        console.log(obj);
        var url = '', tipo = '';
        if ($('#btnGravar').val() == 'Alterar') {
            tipo = 'Alterar';
            url = 'ContasPagar.aspx/Alterar';
        } else {
            tipo = 'Gravar';
            url = 'ContasPagar.aspx/Gravar';
        }
        console.log(obj);
        $.ajax({
            type: "POST",
            url: url,
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                if (source == "OK" & tipo == 'Gravar') {
                    alertCss('Gravar');
                    TabelaLancarDados();
                } else if (source == "OK" & tipo == 'Alterar'){
                    alertCss('Alterar');
                    TabelaLancarDados();
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

        /*limparTabelaTempModal();*/

        $('#lblTabelaInseridosDetalhes').html('');
        $('#avisoModal').addClass('hidden');
        $('#hdnIDContasPagar').val(id);
        /*GravarDetahesTemp('buscar');*/
        $('#ModalDetalhes').modal('show');
        BuscarDadosInseridosDetalhes(id);
        /* $("#ModalDetalhes").modal({ show: true });*/
    }

    function editar(id) {
     
                $.ajax({
                    type: "POST",
                    url: "ContasPagar.aspx/EditarContaPagar",
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        var source = data.d;
                                             
                         
                        $('#hdnObra').val(source.id_obra);
                        $('#hdnFornecedor').val(source.id_fornecedor);
                        $('#hdnIDContasPagar').val(source.id);
                        $('#ddlconta').val(source.conta_bancaria);
                        $('#ddlTipoPgto').val(source.tipo_pgto);
                        $('#txtFornecedor').val(source.desc_fornecedor);
                        $('#txtObras').val(source.desc_obra);
                        $('#txtConta').val(source.desc_conta);
                        $('#txtParcela').val(source.num_parcela);
                        $('#txtValor').val(source.valor_string);
                        $('#ddlDespesa').val(source.id_despesa);
                        $('#txtData').val(source.data);                      
                        $('#ddlTipoPgto').val(source.tipo_pgto);

                        $('#btnGravar').val('Alterar');

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
                //swalWithBootstrapButtons.fire(
                //    'Contrato gerado com sucesso',
                //    'Numero do contrato: ' + $('#hdnNumero_Contrato').val(),
                //    'success'
                //)
                 

    }

    function excluirConta(id) {

        swalWithBootstrapButtons.fire({
            title: 'Deseja excluir conta?',
            text: '',
            icon: 'warning',
            confirmButtonText: 'Sim',
            cancelButtonText: 'Não',
            showCancelButton: true,
            reverseButtons: false,
            allowOutsideClick: false
        }).then((result) => {
            if (result.value) {

                $.ajax({
                    type: "POST",
                    url: "ContasPagar.aspx/ExcluirConta",
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        var source = data.d;

                        TabelaLancarDados();

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
                //swalWithBootstrapButtons.fire(
                //    'Contrato gerado com sucesso',
                //    'Numero do contrato: ' + $('#hdnNumero_Contrato').val(),
                //    'success'
                //)

            } else {

            }



        })



    }

    function limparTabelaTempModal() {

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

    function fecharModal() {
        $("#ModalDetalhes").modal('hide');
        $('#txtDescDetalhes').val('');
        $('#txtQtdeDetalhes').val('');
        $('#txtvalorDetalhes').val('');
        $('#hdnIDContasPagar').val('');
        $('#tbDetalhados').html('');

        /* limparTabelaTempModal();*/

    }

    function GravarDetahesConta() {

        var Contas = {};

        if ($('#txtDescDetalhes').val() == '' || $('#txtQtdeDetalhes').val() == '' || $('#txtvalorDetalhes').val() == '') {

            $('#avisoModal').removeClass('hidden');

        } else {

            $('#avisoModal').addClass('hidden');

            var id_obra = $('#hdnIDContasPagar').val();
            var desc_detalhe = $('#txtDescDetalhes').val();
            var qtde = $('#txtQtdeDetalhes').val();
            var valor = $('#txtvalorDetalhes').val().trim().replace('.', '').replace(',', '.');
            var nf_ = $('#txtNF').val();


            Contas = {
                desc_conta: desc_detalhe,
                num_parcela: qtde,
                valor: valor,
                id: id_obra,
                nf: nf_
            };


            var obj = { 'Contas': Contas };


            $.ajax({
                type: "POST",
                url: "ContasPagar.aspx/GravarDetalhes",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {

                    var dados = JSON.parse(data.d);

                    if (dados.retorno.split('@')[0] == 'OK') {

                        /*$('#lblTabelaInseridosDetalhes').html(dados);*/
                        /* BuscarDadosInseridosTempDetalhes(dados.retorno.split(',')[1]);*/
                        BuscarDadosInseridosDetalhes(dados.retorno.split('@')[1]);
                        $('#txtDescDetalhes').val('');
                        $('#txtQtdeDetalhes').val('');
                        $('#txtvalorDetalhes').val('');
                    }

                    /*BuscaTabelaDetalhesModal(dados);*/

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

    }

    function BuscarDadosInseridosDetalhes(id) {

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/TabelaDetalhesContas",
            data: "{'id':'" + id + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {

                var dados = data.d.split('@')[1];
                var tabela = data.d.split('@')[0];

                $('#txtNF').val(dados);
                $('#lblTabelaInseridosDetalhes').html('');
                $('#lblTabelaInseridosDetalhes').html(tabela);

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

    function BuscarDadosInseridosTempDetalhes() {

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/TabelaTempDetalhesContas",
            data: '',
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {

                var dados = data.d;

                $('#lblTabelaInseridosDetalhes').html(dados);


                /*BuscaTabelaDetalhesModal(dados);*/

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
        $('#txtNF').val('');

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

    function BuscarCliente() {

        window.open("consultar_fornecedor.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
    }

    function selCliente(id, nome, cnpj) {

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/ConsultarFornecedor",
            data: "{'id':'" + id + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                $('#hdnFornecedor').val(source.id);
                $('#txtFornecedor').val(source.RazaoSocial);

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

    function BuscarObra() {

        window.open("consultar_obra.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
    }

    function selObra(id, nome, cnpj) {

        $('#hdnObra').val(id);
        $('#txtObras').val(nome);

        //$.ajax({
        //    type: "POST",
        //    url: "cad_obra.aspx/CarregarObra",
        //    data: "{'id':'" + id + "'}",
        //    contentType: "application/json; charset=utf-8",
        //    dataType: "JSON",
        //    success: function (data) {
        //        var source = data.d;




        //    },
        //    error: function (request, status, error) {
        //        alert(request.responseText);
        //        console.log(request.responseText);
        //        //swalWithBootstrapButtons.fire({
        //        //    title: '',
        //        //    text: 'Erro ao abrir tabela! Tente novamente!',
        //        //    icon: 'error',
        //        //    confirmButtonText: 'OK',
        //        //    allowOutsideClick: false
        //        //}).then((result) => {
        //        /*  });*/
        //    }
        //});
    }

    function baixarConta(id) {

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/BaixarConta",
            data: "{'id':'" + id + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                TabelaLancarDados();

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
        <asp:HiddenField ID="hdnFornecedor" runat="server" />
        <asp:HiddenField ID="hdnObra" runat="server" />
         <asp:HiddenField ID="hdnUsuario" runat="server" />
        <div id="menu">
        </div>
        <div>
            <center>
                <table>
                    <tr>
                        <td colspan="4">
                            <center>
                                <h3>Contas a Pagar</h3>
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlConta" runat="server" CssClass="form-control" Width="350px">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 20px"></td>
                        <td>Vencimento: &nbsp;
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtData" Width="100px" CssClass="form-control" MaxLength="10" placeholder="__/__/____" onkeypress="mascaraMutuario(this,data);" onkeydown="verBackSpace(this,data);" onblur="validateDate(this);"></asp:TextBox>
                        </td>


                    </tr>
                    <tr>
                        <td style="display: inline-flex" colspan="4">
                            <asp:TextBox ID="txtFornecedor" runat="server" placeholder="Fornecedor" CssClass="form-control" Width="350px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Cliente" onclick="BuscarCliente('fonecedor');return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:DropDownList ID="ddlDespesa" runat="server" CssClass="form-control" Width="350px">
                            </asp:DropDownList>
                        </td>



                    </tr>
                    <tr>
                        <td style="display: inline-flex" colspan="4">
                            <asp:TextBox ID="txtObras" runat="server" placeholder="Obra" CssClass="form-control" Width="350px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Cliente" onclick="BuscarObra();return false;" />
                        </td>
                    </tr>


                    <tr>
                    </tr>
                    <%--<tr class="trBody">
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

                        <td colspan="2">
                            <asp:TextBox ID="txtParcela" runat="server" Width="100px" placeholder="Parcela" CssClass="form-control"></asp:TextBox>
                        </td>
                 
                       

                    </tr>  --%>

                    <tr>
                        <td colspan="3" style="display: inline-flex">
                            <asp:TextBox ID="txtValor" runat="server" placeholder="Valor" Width="120px" CssClass="form-control"  onKeyPress="return(moeda(this,'.',',',event))"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="ddlTipoPgto" Width="150px" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Forma Pgto.." Value="0"></asp:ListItem>
                                <asp:ListItem Text="Boleto" Value="BOLETO"></asp:ListItem>
                                <asp:ListItem Text="Dinheiro" Value="DINHEIRO"></asp:ListItem>
                                <asp:ListItem Text="Débito" Value="DEBITO"></asp:ListItem>
                                <asp:ListItem Text="Crédito" Value="CREDITO"></asp:ListItem>
                                <asp:ListItem Text="Cheque" Value="CHEQUE"></asp:ListItem>
                                <asp:ListItem Text="Depósito" Value="DEPÓSITO"></asp:ListItem>
                                <asp:ListItem Text="Pix" Value="PIX"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:TextBox ID="txtParcela" runat="server" Width="100px" placeholder="Parcela" CssClass="form-control"></asp:TextBox>

                        </td>
                    </tr>

                    <tr>

                        <td colspan="4" style="text-align: center">
                            <br />
                            <asp:Button runat="server" ID="btnGravar" CssClass="btn btn-success" Text="Gravar" OnClientClick="GravarConta();return false;" />
                        </td>
                        <td style="text-align: center">
                            <br />
                            <asp:Button ID="btnPagas" runat="server" CssClass="btn btn-info" Text="Pagas" OnClientClick="TabelaLancarDadosPagas();return false;" />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        <hr />

        <div style="width: 100%">
            <br />
            <center>
                <table style="width: 80%">
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
                            <table style="width: 100%">
                                <tr>
                                    <td colspan="4">
                                        <center>
                                            <asp:TextBox runat="server" ID="txtNF" CssClass="form-control" Width="150px" placeholder="NF"></asp:TextBox>
                                        </center>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDescDetalhes" CssClass="form-control" placeholder="item"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtQtdeDetalhes" CssClass="form-control" Width="60px" placeholder="Qtde"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtvalorDetalhes" CssClass="form-control" Width="150px" placeholder="R$"></asp:TextBox>
                                    </td>
                                    <td>
                                        <input type="button" class="btn btn-info" value="Inserir" onclick="GravarDetahesConta()" />
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="4">
                                        <center>
                                            <label id="lblTabelaInseridosDetalhes"></label>
                                        </center>
                                    </td>
                                </tr>
                            </table>
                            <label id="avisoModal" style="color: red" class="hidden"><b>É necessario preencher os campos</b></label>
                        </center>
                    </div>
                    <div class="modal-footer">
                        <%-- <button type="button" id="btnAutorizar" style="width: 150px" class="swal2-cancel btn btn-success" onclick="GravarDetalhes();">Gravar Detalhados</button>--%>
                        <button type="button" id="btnFechar" class="swal2-cancel btn btn-danger" onclick="fecharModal();">Fechar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
