namespace TrabalhoAPI.Models.ViewModels
{
    public class ViewModelProdutosEmEstoque
    {
        public long? IdProduto { get; set; }
        public string? CodBarras { get; set; }
        public string? Descricao { get; set; }
        public long? Quantidade { get; set; }

        public ViewModelProdutosEmEstoque()
        {
            IdProduto = 0;
        }
    }
}
