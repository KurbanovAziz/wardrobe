import 'package:hive/hive.dart';

part 'brindi_enum.g.dart';

@HiveType(typeId: 0)
enum BrindiType {
  @HiveField(0)
  acneStudios,
  @HiveField(1)
  alessandraRich,
  @HiveField(2)
  adidas,
  @HiveField(3)
  armani,
  @HiveField(4)
  balenciaga,
  @HiveField(5)
  balmain,
  @HiveField(6)
  bottegaVeneta,
  @HiveField(7)
  burberry,
  @HiveField(8)
  calvinKlein,
  @HiveField(9)
  cartier,
  @HiveField(10)
  chanel,
  @HiveField(11)
  chloe,
  @HiveField(12)
  christianDior,
  @HiveField(13)
  coach,
  @HiveField(14)
  dolceGabbana,
  @HiveField(15)
  drMartens,
  @HiveField(16)
  fendi,
  @HiveField(17)
  givenchy,
  @HiveField(18)
  gucci,
  @HiveField(19)
  hermes,
  @HiveField(20)
  hugoBoss,
  @HiveField(21)
  isabelMarant,
  @HiveField(22)
  jacquemus,
  @HiveField(23)
  jimmyChoo,
  @HiveField(24)
  kenzo,
  @HiveField(25)
  lacoste,
  @HiveField(26)
  lanvin,
  @HiveField(27)
  leviStraussCo,
  @HiveField(28)
  loewe,
  @HiveField(29)
  louisVuitton,
  @HiveField(30)
  miuMiu,
  @HiveField(31)
  moncler,
  @HiveField(32)
  moschino,
  @HiveField(33)
  nike,
  @HiveField(34)
  offWhite,
  @HiveField(35)
  prada,
  @HiveField(36)
  puma,
  @HiveField(37)
  ralphLauren,
  @HiveField(38)
  reebok,
  @HiveField(39)
  rickOwens,
  @HiveField(40)
  robertoCavalli,
  @HiveField(41)
  saintLaurent,
  @HiveField(42)
  salvatoreFerragamo,
  @HiveField(43)
  stellaMcCartney,
  @HiveField(44)
  stoneIsland,
  @HiveField(45)
  supreme,
  @HiveField(46)
  theNorthFace,
  @HiveField(47)
  thomBrowne,
  @HiveField(48)
  tomFord,
  @HiveField(49)
  tommyHilfiger,
  @HiveField(50)
  toryBurch,
  @HiveField(51)
  underArmour,
  @HiveField(52)
  valentino,
  @HiveField(53)
  versace,
  @HiveField(54)
  vetements,
  @HiveField(55)
  victoriaBeckham,
  @HiveField(56)
  vivienneWestwood,
  @HiveField(57)
  yvesSaintLaurent,
  @HiveField(58)
  alexanderMcQueen,
  @HiveField(59)
  commeDesGarcons,
  @HiveField(60)
  ermenegildoZegna,
  @HiveField(61)
  jeanPaulGaultier,
  @HiveField(62)
  philippPlein,
  @HiveField(63)
  proenzaSchouler,
  @HiveField(64)
  ragBone,
  @HiveField(65)
  theory,
  @HiveField(66)
  tibi,
  @HiveField(67)
  ugg,
  @HiveField(68)
  uniqlo,
  @HiveField(69)
  vince,
  @HiveField(70)
  zara
}

extension BrindiTypeExtension on BrindiType {
  String getImya() {
    switch (this) {
      case BrindiType.acneStudios:
        return 'Acne Studios';
      case BrindiType.alessandraRich:
        return 'Alessandra Rich';
      case BrindiType.adidas:
        return 'Adidas';
      case BrindiType.armani:
        return 'Armani';
      case BrindiType.balenciaga:
        return 'Balenciaga';
      case BrindiType.balmain:
        return 'Balmain';
      case BrindiType.bottegaVeneta:
        return 'Bottega Veneta';
      case BrindiType.burberry:
        return 'Burberry';
      case BrindiType.calvinKlein:
        return 'Calvin Klein';
      case BrindiType.cartier:
        return 'Cartier';
      case BrindiType.chanel:
        return 'Chanel';
      case BrindiType.chloe:
        return 'Chloé';
      case BrindiType.christianDior:
        return 'Christian Dior';
      case BrindiType.coach:
        return 'Coach';
      case BrindiType.dolceGabbana:
        return 'Dolce & Gabbana';
      case BrindiType.drMartens:
        return 'Dr. Martens';
      case BrindiType.fendi:
        return 'Fendi';
      case BrindiType.givenchy:
        return 'Givenchy';
      case BrindiType.gucci:
        return 'Gucci';
      case BrindiType.hermes:
        return 'Hermès';
      case BrindiType.hugoBoss:
        return 'Hugo Boss';
      case BrindiType.isabelMarant:
        return 'Isabel Marant';
      case BrindiType.jacquemus:
        return 'Jacquemus';
      case BrindiType.jimmyChoo:
        return 'Jimmy Choo';
      case BrindiType.kenzo:
        return 'Kenzo';
      case BrindiType.lacoste:
        return 'Lacoste';
      case BrindiType.lanvin:
        return 'Lanvin';
      case BrindiType.leviStraussCo:
        return 'Levi Strauss & Co.';
      case BrindiType.loewe:
        return 'Loewe';
      case BrindiType.louisVuitton:
        return 'Louis Vuitton';
      case BrindiType.miuMiu:
        return 'Miu Miu';
      case BrindiType.moncler:
        return 'Moncler';
      case BrindiType.moschino:
        return 'Moschino';
      case BrindiType.nike:
        return 'Nike';
      case BrindiType.offWhite:
        return 'Off-White';
      case BrindiType.prada:
        return 'Prada';
      case BrindiType.puma:
        return 'Puma';
      case BrindiType.ralphLauren:
        return 'Ralph Lauren';
      case BrindiType.reebok:
        return 'Reebok';
      case BrindiType.rickOwens:
        return 'Rick Owens';
      case BrindiType.robertoCavalli:
        return 'Roberto Cavalli';
      case BrindiType.saintLaurent:
        return 'Saint Laurent';
      case BrindiType.salvatoreFerragamo:
        return 'Salvatore Ferragamo';
      case BrindiType.stellaMcCartney:
        return 'Stella McCartney';
      case BrindiType.stoneIsland:
        return 'Stone Island';
      case BrindiType.supreme:
        return 'Supreme';
      case BrindiType.theNorthFace:
        return 'The North Face';
      case BrindiType.thomBrowne:
        return 'Thom Browne';
      case BrindiType.tomFord:
        return 'Tom Ford';
      case BrindiType.tommyHilfiger:
        return 'Tommy Hilfiger';
      case BrindiType.toryBurch:
        return 'Tory Burch';
      case BrindiType.underArmour:
        return 'Under Armour';
      case BrindiType.valentino:
        return 'Valentino';
      case BrindiType.versace:
        return 'Versace';
      case BrindiType.vetements:
        return 'Vetements';
      case BrindiType.victoriaBeckham:
        return 'Victoria Beckham';
      case BrindiType.vivienneWestwood:
        return 'Vivienne Westwood';
      case BrindiType.yvesSaintLaurent:
        return 'Yves Saint Laurent';
      case BrindiType.alexanderMcQueen:
        return 'Alexander McQueen';
      case BrindiType.commeDesGarcons:
        return 'Comme des Garçons';
      case BrindiType.ermenegildoZegna:
        return 'Ermenegildo Zegna';
      case BrindiType.jeanPaulGaultier:
        return 'Jean-Paul Gaultier';
      case BrindiType.philippPlein:
        return 'Philipp Plein';
      case BrindiType.proenzaSchouler:
        return 'Proenza Schouler';
      case BrindiType.ragBone:
        return 'Rag & Bone';
      case BrindiType.theory:
        return 'Theory';
      case BrindiType.tibi:
        return 'Tibi';
      case BrindiType.ugg:
        return 'UGG';
      case BrindiType.uniqlo:
        return 'Uniqlo';
      case BrindiType.vince:
        return 'Vince';
      case BrindiType.zara:
        return 'Zara';
      default:
        return '';
    }
  }
}

@HiveType(typeId: 1)
enum WhereToWear {
  @HiveField(0)
  work,
  @HiveField(1)
  casual,
  @HiveField(2)
  party,
  @HiveField(3)
  wedding,
  @HiveField(4)
  date,
  @HiveField(5)
  beach,
  @HiveField(6)
  gym,
  @HiveField(7)
  formalEvent,
  @HiveField(8)
  travel,
  @HiveField(9)
  outdoor,
  @HiveField(10)
  dinner,
  @HiveField(11)
  nightOut,
  @HiveField(12)
  concert,
  @HiveField(13)
  festival,
  @HiveField(14)
  shopping,
  @HiveField(15)
  home,
  @HiveField(16)
  meeting,
  @HiveField(17)
  sportsEvent,
  @HiveField(18)
  picnic,
  @HiveField(19)
  officeParty
}

extension WhereToWearExtension on WhereToWear {
  String getImya() {
    switch (this) {
      case WhereToWear.work:
        return 'Work';
      case WhereToWear.casual:
        return 'Casual';
      case WhereToWear.party:
        return 'Party';
      case WhereToWear.wedding:
        return 'Wedding';
      case WhereToWear.date:
        return 'Date';
      case WhereToWear.beach:
        return 'Beach';
      case WhereToWear.gym:
        return 'Gym';
      case WhereToWear.formalEvent:
        return 'Formal Event';
      case WhereToWear.travel:
        return 'Travel';
      case WhereToWear.outdoor:
        return 'Outdoor';
      case WhereToWear.dinner:
        return 'Dinner';
      case WhereToWear.nightOut:
        return 'Night Out';
      case WhereToWear.concert:
        return 'Concert';
      case WhereToWear.festival:
        return 'Festival';
      case WhereToWear.shopping:
        return 'Shopping';
      case WhereToWear.home:
        return 'Home';
      case WhereToWear.meeting:
        return 'Meeting';
      case WhereToWear.sportsEvent:
        return 'Sports Event';
      case WhereToWear.picnic:
        return 'Picnic';
      case WhereToWear.officeParty:
        return 'Office Party';
      default:
        return '';
    }
  }
}

@HiveType(typeId: 3)
enum GarderobStyle {
  @HiveField(0)
  classic,
  @HiveField(1)
  sport,
  @HiveField(2)
  casual,
  @HiveField(3)
  festive,
  @HiveField(4)
  home,
  @HiveField(5)
  outside,
}

@HiveType(typeId: 2)
enum GarderobCategory {
  @HiveField(0)
  outerwear,
  @HiveField(1)
  underwear,
  @HiveField(2)
  dressOveralls,
  @HiveField(3)
  shoes,
  @HiveField(4)
  accessories,
  @HiveField(5)
  sportswear,
  @HiveField(6)
  homewear,
}

extension GarderobCategoryExtension on GarderobCategory {
  String getImya() {
    switch (this) {
      case GarderobCategory.outerwear:
        return 'Outerwear';
      case GarderobCategory.underwear:
        return 'Underwear';
      case GarderobCategory.dressOveralls:
        return 'Dress overalls';
      case GarderobCategory.shoes:
        return 'Shoes';
      case GarderobCategory.accessories:
        return 'Accessories';
      case GarderobCategory.sportswear:
        return 'Sportswear';
      case GarderobCategory.homewear:
        return 'Homewear';
      default:
        return '';
    }
  }
}

extension GarderobStyleExtension on GarderobStyle {
  String getImya() {
    switch (this) {
      case GarderobStyle.classic:
        return 'Classic';
      case GarderobStyle.sport:
        return 'Sport';
      case GarderobStyle.casual:
        return 'Casual';
      case GarderobStyle.festive:
        return 'Festive';
      case GarderobStyle.home:
        return 'Home';
      case GarderobStyle.outside:
        return 'Outside';
      default:
        return '';
    }
  }
}
