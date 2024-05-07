////////////////// Calculadora de Partidas Rankeadas ////////////

// Criar classe de Herói
class Hero {
    constructor(nome, vitoria, derrota) {
      this.nome = nome;
      this.vitoria = vitoria;
      this.derrota = derrota;
    }
    // método para identificar saldo
    calcularSaldoRankeadas(){
        // esse "if" é para garantir que saldo não fique negativo
        if (this.vitoria < this.derrota) {
            let vitoriaVaiParaDerrota = this.vitoria
            this.vitoria = this.derrota
            this.derrota = vitoriaVaiParaDerrota
        }
        return this.vitoria-this.derrota 
    }
    // método para determinar ranking
    determinarRanking(){
        let saldoRankeadas = this.calcularSaldoRankeadas()
        let rank;
        if (saldoRankeadas >= 100) {
            rank = "Imortal"
        }
        else if (saldoRankeadas >= 90) {
            rank = "Lendário"
        }
        else if (saldoRankeadas >= 80) {
            rank = "Diamante"
        }
        else if (saldoRankeadas >= 50) {
            rank = "Ouro"
        }
        else if (saldoRankeadas >= 20) {
            rank = "Prata"
        }
        else if (saldoRankeadas >= 10) {
            rank = "Bronze"
        }
        else if (saldoRankeadas >= 0) {
            rank = "Ferro"
        }
        else {
            rank = "Lata"
        }
        return rank
    }
}
// Gerar número aleatório 
const gerarNumRanPositivo = () => Math.floor(Math.random()* 150);
// Criando os heróis
const Heroes = [
    new Hero("Capitão América", gerarNumRanPositivo(), gerarNumRanPositivo()),
    new Hero("Hulk", gerarNumRanPositivo(), gerarNumRanPositivo()),
    new Hero("Homem de Ferro", gerarNumRanPositivo(), gerarNumRanPositivo()),
    new Hero("Thor", gerarNumRanPositivo(), gerarNumRanPositivo()),
    new Hero("Gavião-Arqueiro", gerarNumRanPositivo(), gerarNumRanPositivo())
];
// Loops para Outputs/Mensagens
for (let hero of Heroes) {
    console.log ("O Herói " + hero.nome + " tem saldo de " + hero.calcularSaldoRankeadas() + " está no nível de " + hero.determinarRanking() )
}
// Ordenar do ranking maior para o menor
Heroes.sort((a, b) => b.calcularSaldoRankeadas() - a.calcularSaldoRankeadas());
// Outputs/Mensagens
console.log ("///////////////// RANKING /////////////////")

console.log ("Herói||Saldo de Vitórias|| Nível")

for (let hero of Heroes) {
    console.log (hero.nome + "  " + hero.calcularSaldoRankeadas() + "  " + hero.determinarRanking() )
}
