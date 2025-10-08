class Corsa {
  const property color 
  
  method capacidad() = 4

  method velocidadMaxima() = 150

  method peso() = 1300
}

class Kwid{
  var tieneTanqueDeGas 

  method agregarTanque(){
    tieneTanqueDeGas = true
  }

  method quitarTanque(){
    tieneTanqueDeGas = false
  }

  method tieneTanqueDeGas() = tieneTanqueDeGas

  method capacidad(){
    if(tieneTanqueDeGas){
      return 3
    }else{
      return 4
    }
  }

  method velocidadMaxima(){
    if(tieneTanqueDeGas){
      return 110
    }else{
      return 120
    }
  }

  method peso(){
    if(tieneTanqueDeGas){
      return 1350
    }else{
      return 1200
    }
  }

  method color() = "Azul"
}

object traffic{
  var property interior = comodo
  var property motor = pulenta

  method capacidad() = interior.capacidad()
  method velocidadMaxima() = motor.velocidadMaxima()
  method peso() = 4000 + interior.peso() + motor.peso()
  method color() = "blanco"
}

class AutoEspecial{
  const property capacidad 
  const property velocidadMaxima 
  const property peso 
  const property color 
}

class Dependencia{
  const property pedidos = #{}
  const property flota = #{}
  var property empleados

  method agregarPedido(unPedido){
    pedidos.add(unPedido)
  }

  method removerPedido(unPedido){
    pedidos.remove(unPedido)
  }

  method agregarAflota(rodado){
    flota.add(rodado)
  }

  method quitarDeFlota(rodado){
    flota.remove(rodado)
  }

  method pesoTotalFlota(){
    flota.sum({unRodado => unRodado.peso()})
  }

  method estaBienEquipada(){
    return flota.size() >= 3 && flota.all({unRodado => unRodado.velocidadMaxima() >= 100})
  }

  method capacidadTotalEnColor(color){
    return flota.filter({unRodado => unRodado.color() == color}).sum({unRodado => unRodado.capacidad()})
  }

  method colorDelRodadoMasRapido() = self.rodadoMasRapido()

  method rodadoMasRapido() = flota.max({unRodado => unRodado.velocidadMaxima()})

  method capacidadFaltate() = empleados - self.capacidadTotal()

  method capacidadTotal() = flota.sum({unRodado => unRodado.capacidad()})

  method esGrande() = empleados >= 40 && flota.size() >= 5

  method totalDePasajeros(){
    pedidos.sum({ unPedido => unPedido.cantidadDePasajeros()})
  }

  method cualesPedidosNoSonSatisfechos(){
    pedidos.filter({unPedido => unPedido.satisfaceElPedido()})
  } // reveeer esto y test

  method todosLosPedidosSonIncompatibles(color){
    return pedidos.all({unPedido => unPedido.esColorIncompatible(color)})
  }

  method relajarATodos(){
    pedidos.forEach({unPedido => unPedido.relajar()})
  }
}

object comodo {
  method capacidad() = 5
  method peso() = 700
}

object popular{
  method capacidad() = 12
  method peso() = 1000
}

object pulenta{
  method peso() = 800
  method velocidadMaxima() = 130
}

object bataton{
  method peso() = 500
  method velocidadMaxima() = 80
}

  // etapa 2
class Pedido{
  const property distancia 
  var tiempoMaximo
  const property cantidadDePasajeros
  const property coloresIncompatibles

  method tiempoMaximo() = tiempoMaximo

  method velocidadRequerida() = distancia / tiempoMaximo

  method satisfaceElPedido(auto){
    return auto.velocidadMaxima() >= self.velocidadRequerida() + 10 &&
    auto.capacidad() >= cantidadDePasajeros &&
    !coloresIncompatibles.contains(auto.color())
  }
  method acelerar(){
    tiempoMaximo -= 1
  }
  
  method relajar(){
    tiempoMaximo += 1
  }

  method esColorIncompatible(unColor){
    return coloresIncompatibles.contains(unColor)
  }
}