

protocol Assembler: class,
    AppAssembler,
    ListCityAssembler,
    WeatherDataAssembler, RepositoryAssembler, HomeAssembler {
    
}

final class DefaultAsssembler: Assembler {
}
