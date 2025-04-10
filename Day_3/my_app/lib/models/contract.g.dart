// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContractCollection on Isar {
  IsarCollection<Contract> get contracts => this.collection();
}

const ContractSchema = CollectionSchema(
  name: r'Contract',
  id: 6075293080182411034,
  properties: {
    r'contract_type': PropertySchema(
      id: 0,
      name: r'contract_type',
      type: IsarType.string,
    ),
    r'created_at': PropertySchema(
      id: 1,
      name: r'created_at',
      type: IsarType.dateTime,
    ),
    r'end_date': PropertySchema(
      id: 2,
      name: r'end_date',
      type: IsarType.dateTime,
    ),
    r'start_date': PropertySchema(
      id: 3,
      name: r'start_date',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 4,
      name: r'status',
      type: IsarType.string,
    ),
    r'sync_status': PropertySchema(
      id: 5,
      name: r'sync_status',
      type: IsarType.string,
    ),
    r'user_id': PropertySchema(
      id: 6,
      name: r'user_id',
      type: IsarType.long,
    )
  },
  estimateSize: _contractEstimateSize,
  serialize: _contractSerialize,
  deserialize: _contractDeserialize,
  deserializeProp: _contractDeserializeProp,
  idName: r'contractId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _contractGetId,
  getLinks: _contractGetLinks,
  attach: _contractAttach,
  version: '3.1.0+1',
);

int _contractEstimateSize(
  Contract object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contractType.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.syncStatus.length * 3;
  return bytesCount;
}

void _contractSerialize(
  Contract object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contractType);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.endDate);
  writer.writeDateTime(offsets[3], object.startDate);
  writer.writeString(offsets[4], object.status);
  writer.writeString(offsets[5], object.syncStatus);
  writer.writeLong(offsets[6], object.userId);
}

Contract _contractDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Contract(
    contractId: id,
    contractType: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    endDate: reader.readDateTime(offsets[2]),
    startDate: reader.readDateTime(offsets[3]),
    status: reader.readString(offsets[4]),
    syncStatus: reader.readStringOrNull(offsets[5]) ?? 'created',
    userId: reader.readLong(offsets[6]),
  );
  return object;
}

P _contractDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? 'created') as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contractGetId(Contract object) {
  return object.contractId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _contractGetLinks(Contract object) {
  return [];
}

void _contractAttach(IsarCollection<dynamic> col, Id id, Contract object) {
  object.contractId = id;
}

extension ContractQueryWhereSort on QueryBuilder<Contract, Contract, QWhere> {
  QueryBuilder<Contract, Contract, QAfterWhere> anyContractId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContractQueryWhere on QueryBuilder<Contract, Contract, QWhereClause> {
  QueryBuilder<Contract, Contract, QAfterWhereClause> contractIdEqualTo(
      Id contractId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: contractId,
        upper: contractId,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> contractIdNotEqualTo(
      Id contractId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: contractId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: contractId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: contractId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: contractId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> contractIdGreaterThan(
      Id contractId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: contractId, includeLower: include),
      );
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> contractIdLessThan(
      Id contractId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: contractId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> contractIdBetween(
    Id lowerContractId,
    Id upperContractId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerContractId,
        includeLower: includeLower,
        upper: upperContractId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContractQueryFilter
    on QueryBuilder<Contract, Contract, QFilterCondition> {
  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contractId',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      contractIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contractId',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractId',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contractId',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contractId',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contractId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      contractTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract_type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      contractTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract_type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      contractTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_type',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      contractTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract_type',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created_at',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> endDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'end_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> endDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'end_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> endDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'end_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> endDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'end_date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> startDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'start_date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sync_status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sync_status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sync_status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sync_status',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition>
      syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sync_status',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> userIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'user_id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'user_id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'user_id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'user_id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContractQueryObject
    on QueryBuilder<Contract, Contract, QFilterCondition> {}

extension ContractQueryLinks
    on QueryBuilder<Contract, Contract, QFilterCondition> {}

extension ContractQuerySortBy on QueryBuilder<Contract, Contract, QSortBy> {
  QueryBuilder<Contract, Contract, QAfterSortBy> sortByContractType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_type', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByContractTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_type', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end_date', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end_date', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync_status', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync_status', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'user_id', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'user_id', Sort.desc);
    });
  }
}

extension ContractQuerySortThenBy
    on QueryBuilder<Contract, Contract, QSortThenBy> {
  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContractId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractId', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContractIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractId', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContractType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_type', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContractTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_type', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end_date', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end_date', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync_status', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync_status', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'user_id', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'user_id', Sort.desc);
    });
  }
}

extension ContractQueryWhereDistinct
    on QueryBuilder<Contract, Contract, QDistinct> {
  QueryBuilder<Contract, Contract, QDistinct> distinctByContractType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_type',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created_at');
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'end_date');
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'start_date');
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctBySyncStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sync_status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'user_id');
    });
  }
}

extension ContractQueryProperty
    on QueryBuilder<Contract, Contract, QQueryProperty> {
  QueryBuilder<Contract, int, QQueryOperations> contractIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractId');
    });
  }

  QueryBuilder<Contract, String, QQueryOperations> contractTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_type');
    });
  }

  QueryBuilder<Contract, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created_at');
    });
  }

  QueryBuilder<Contract, DateTime, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'end_date');
    });
  }

  QueryBuilder<Contract, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'start_date');
    });
  }

  QueryBuilder<Contract, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Contract, String, QQueryOperations> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sync_status');
    });
  }

  QueryBuilder<Contract, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'user_id');
    });
  }
}
