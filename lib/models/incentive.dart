class Incentive {
  final int id;
  final String name;
  final String description;
  final String legalReference;
  final String lawSection;
  final String sector;
  final String eligebility;
  final String rewardingAuthority;
  final String implementingAuthority;
  final String incentivePackage;

  Incentive(
      {this.id,
      this.name,
      this.description,
      this.legalReference,
      this.lawSection,
      this.sector,
      this.eligebility,
      this.rewardingAuthority,
      this.implementingAuthority,
      this.incentivePackage});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "legalReference": legalReference,
      "lawSection": lawSection,
      "sector": sector,
      "eligebility": eligebility,
      "rewardingAuthority": rewardingAuthority,
      "implementingAuthority": implementingAuthority,
      "incentivePackage": incentivePackage
    };
  }

  factory Incentive.fromJson(Map<String, dynamic> json) {
    return Incentive(
      id: json['id'],
      name: json['name'].join('\n\n'),
      legalReference: json['legal_reference'].join('\n\n'),
      lawSection: json['law_section'].join('\n\n'),
      description: json['description'].join('\n\n'),
      sector: json['sector'].join('\n\n'),
      eligebility: json['eligebility'].join('\n\n'),
      rewardingAuthority: json['rewarding_authority'].join('\n\n'),
      implementingAuthority: json['implementing_authority'].join('\n\n'),
      incentivePackage: json['incentive_package'],
    );
  }
}
