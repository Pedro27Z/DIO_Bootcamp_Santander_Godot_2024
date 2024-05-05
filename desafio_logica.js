//Classificador de Nível de Herói

// Variáveis
let Heroes = ["Hércules", "Aquiles", "Perseu", "Teseu", "Jasão"] 
let Hero = ""
let XP = 0
let Level = ""

// Laço de repetição, operadores
for (let i = 0; i < 5; i++){
    XP = Math.floor(Math.random()*10500)
    
    Hero = Heroes[i]

  // Estrutura de decisão
    if (XP >= 10000){
        Level = "Radiante"
    }
    else if (XP >=9000){
        Level = "Imortal"
    }
    else if (XP >=8000){
        Level = "Ascendente"
    }
    else if (XP >=7000){
        Level = "de Platina"
    }
    else if (XP >=5000){
        Level = "de Ouro"
    }
    else if (XP >=2000){
        Level = "de Prata"
    }
    else if (XP >=1000){
        Level = "de Bronze"
    }
    else if (XP < 1000){
        Level = "de Ferro"
    }
    else {
        Level = "de Lata"
    }

  // Saída
    console.log("O herói " + Hero + " tem " + XP + " de experência e está no Nível Guerreiro " + Level)

    
}
