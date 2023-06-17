namespace TrabalhoAPI.Models.ViewModels
{
    public class ViewModelDisponibilidadeProdutosPorEstoque
    {
        public long? idEstoque { get; set; }
        public string? codBarras { get; set; }
        public string? descricao { get; set; }
        public long? IdProduto { get; set; }
        public long? Quantidade { get; set; }

        public ViewModelDisponibilidadeProdutosPorEstoque()
        {
            IdProduto = 0;
        }
    }
}
