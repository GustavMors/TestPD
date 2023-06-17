namespace TrabalhoAPI.Models.ViewModels
{
    public class ComprasViewModel
    {
        public string CNPJ { get; set; }
        public string CodBarras { get; set; }
        public long Quantidade { get; set; }
        public long IdProduto { get; set; }
        public long IdFornecedor { get; set; }
        public long IdFuncionarioSol { get; set; }
        public long IdFuncionarioAut { get; set; }
    }
}
