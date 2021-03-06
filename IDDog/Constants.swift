//
//  Constants.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 28.02.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import Foundation

struct K {
  
  static let appName = "IDDog"
  
  struct SegueID {
    static let mainVC2BreedDetailsVC = "MainVC2BreedDetailsVC"
  }
  
  struct Nib {
    static let dogBreedCellNib = "DogBreedTableViewCell"
  }
  
  struct Cell {
    static let dogBreedCell = "DogBreedCell"
  }
  
  static let availableDogBreeds = DogBreedKey.allCases.map { $0.rawValue }
  
  enum DogBreedKey: String, CaseIterable {
    case chihuahua = "chihuahua"
    case japaneseSpaniel = "japanese spaniel"
    case malteseDog = "maltese"
    case pekinese = "pekingese"
    case shihTzu = "shih-tzu"
    case blenheimSpaniel = "blenheim spaniel"
    case papillon = "papillon"
    case toyTerrier = "toy terrier"
    case rhodesianRidgeback = "rhodesian ridgeback"
    case afghanHound = "afghan hound"
    case basset = "basset hound"
    case beagle = "beagle"
    case bloodhound = "bloodhound"
    case bluetick = "bluetick"
    case blackAndTanCoonhound = "black-and-tan coonhound"
    case walkerHound = "walker hound"
    case englishFoxhound = "english foxhound"
    case redbone = "redbone"
    case borzoi = "borzoi"
    case irishWolfhound = "irish wolfhound"
    case italianGreyhound = "italian greyhound"
    case whippet = "whippet"
    case ibizanHound = "ibizan hound"
    case norwegianElkhound = "norwegian elkhound"
    case otterhound = "otterhound"
    case saluki = "saluki"
    case scottishDeerhound = "scottish deerhound"
    case weimaraner = "weimaraner"
    case staffordshireBullterrier = "staffordshire bullterrier"
    case americanStaffordshireTerrier = "american staffordshire terrier"
    case bedlingtonTerrier = "bedlington terrier"
    case borderTerrier = "border terrier"
    case kerryBlueTerrier = "kerry blue terrier"
    case irishTerrier = "irish terrier"
    case norfolkTerrier = "norfolk terrier"
    case norwichTerrier = "norwich terrier"
    case yorkshireTerrier = "yorkshire terrier"
    case wireHairedFoxTerrier = "wire-haired fox terrier"
    case lakelandTerrier = "lakeland terrier"
    case sealyhamTerrier = "sealyham terrier"
    case airedale = "airedale terrier"
    case cairn = "cairn terrier"
    case australianTerrier = "australian terrier"
    case dandieDinmont = "dandie dinmont terrier"
    case bostonBull = "boston terrier"
    case miniatureSchnauzer = "miniature schnauzer"
    case giantSchnauzer = "giant schnauzer"
    case standardSchnauzer = "standard schnauzer"
    case scotchTerrier = "scottish terrier"
    case tibetanTerrier = "tibetan terrier"
    case silkyTerrier = "sydney silky"
    case softCoatedWheatenTerrier = "soft-coated wheaten terrier"
    case westHighlandWhiteTerrier = "west highland white terrier"
    case lhasa = "lhasa apso"
    case flatCoatedRetriever = "flat-coated retriever"
    case curlyCoatedRetriever = "curly-coated retriever"
    case goldenRetriever = "golden retriever"
    case labradorRetriever = "labrador retriever"
    case chesapeakeBayRetriever = "chesapeake bay retriever"
    case germanShortHairedPointer = "german short-haired pointer"
    case vizsla = "vizsla"
    case englishSetter = "english setter"
    case irishSetter = "irish setter"
    case gordonSetter = "gordon setter"
    case brittanySpaniel = "brittany spaniel"
    case clumber = "clumber spaniel"
    case englishSpringer = "english springer spaniel"
    case welshSpringerSpaniel = "welsh springer spaniel"
    case cockerSpaniel = "cocker spaniel"
    case sussexSpaniel = "sussex spaniel"
    case irishWaterSpaniel = "irish water spaniel"
    case kuvasz = "kuvasz"
    case schipperke = "schipperke"
    case groenendael = "groenendael"
    case malinois = "malinois"
    case briard = "briard"
    case kelpie = "kelpie"
    case komondor = "komondor"
    case oldEnglishSheepdog = "old english sheepdog"
    case shetlandSheepdog = "shetland sheepdog"
    case collie = "collie"
    case borderCollie = "border collie"
    case bouvierDesFlandres = "bouvier des flandres"
    case rottweiler = "rottweiler"
    case germanShepherd = "german shepherd"
    case doberman = "dobermann"
    case miniaturePinscher = "miniature pinscher"
    case greaterSwissMountainDog = "greater swiss mountain dog"
    case berneseMountainDog = "bernese mountain dog"
    case appenzeller = "appenzeller"
    case entleBucher = "entlebucher"
    case boxer = "boxer"
    case bullMastiff = "bull mastiff"
    case tibetanMastiff = "tibetan mastiff"
    case frenchBulldog = "french bulldog"
    case greatDane = "great dane"
    case saintBernard = "st bernard"
    case eskimoDog = "eskimo dog"
    case malamute = "alaskan malamute"
    case siberianHusky = "siberian husky"
    case affenpinscher = "affenpinscher"
    case basenji = "basenji"
    case pug = "pug"
    case leonberg = "leonberger"
    case newfoundland = "newfoundland"
    case greatPyrenees = "great pyrenees"
    case samoyed = "samoyed"
    case pomeranian = "pomeranian"
    case chow = "chow"
    case keeshond = "keeshond"
    case brabanconGriffon = "brabancon griffon"
    case pembroke = "pembroke welsh corgi"
    case cardigan = "cardigan welsh corgi"
    case toyPoodle = "toy poodle"
    case miniaturePoodle = "miniature poodle"
    case standardPoodle = "standard poodle"
    case mexicanHairless = "mexican hairless"
    case dingo = "dingo"
    case dhole = "dhole"
    case africanHuntingDog = "african hunting dog"
  }
}
