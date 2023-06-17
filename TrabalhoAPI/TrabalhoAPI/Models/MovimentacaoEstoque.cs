namespace TrabalhoAPI.Models
{
    public class MovimentacaoEstoque
    {
        public long IdMovimentacaoEstoque { get; set; }
        public long IdEstoqueRecebedor { get; set; }
        public long IdEstoqueSaida { get; set; }
        public long IdTipoMovimentacaoEstoque { get; set; }
        public long IdFuncionarioSolicitador { get; set; }
        public long IdFuncionarioAutenticador { get; set; }
        public long IdProduto { get; set; }
        public long Quantidade { get; set; }

        public MovimentacaoEstoque()
        {

        }

    }
}
