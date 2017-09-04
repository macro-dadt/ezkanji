extension RowConvertible where Self: TableMapping {
    
    // MARK: Fetching All
    
    /// A cursor over all records fetched from the database.
    ///
    ///     let persons = try Person.fetchCursor(db) // DatabaseCursor<Person>
    ///     while let person = try persons.next() {  // Person
    ///         ...
    ///     }
    ///
    /// Records are iterated in the natural ordering of the table.
    ///
    /// If the database is modified during the cursor iteration, the remaining
    /// elements are undefined.
    ///
    /// The cursor must be iterated in a protected dispath queue.
    ///
    /// - parameter db: A database connection.
    /// - returns: A cursor over fetched records.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchCursor(_ db: Database) throws -> DatabaseCursor<Self> {
        return try all().fetchCursor(db)
    }
    
    /// An array of all records fetched from the database.
    ///
    ///     let persons = try Person.fetchAll(db) // [Person]
    ///
    /// - parameter db: A database connection.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchAll(_ db: Database) throws -> [Self] {
        return try all().fetchAll(db)
    }
    
    /// The first found record.
    ///
    ///     let person = try Person.fetchOne(db) // Person?
    ///
    /// - parameter db: A database connection.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchOne(_ db: Database) throws -> Self? {
        return try all().fetchOne(db)
    }
}

extension RowConvertible where Self: TableMapping {
    
    // MARK: Fetching by Single-Column Primary Key
    
    // TODO GRDB 2.0: make the result non optional
    /// Returns a cursor over records, given their primary keys.
    ///
    ///     let persons = try Person.fetchCursor(db, keys: [1, 2, 3]) // DatabaseCursor<Person>
    ///     while let person = try persons.next() {
    ///         ...
    ///     }
    ///
    /// Records are iterated in unspecified order.
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - keys: A sequence of primary keys.
    /// - returns: A cursor over fetched records.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchCursor<Sequence: Swift.Sequence>(_ db: Database, keys: Sequence) throws -> DatabaseCursor<Self>? where Sequence.Iterator.Element: DatabaseValueConvertible {
        return try filter(db, keys: keys).fetchCursor(db)
    }
    
    /// Returns an array of records, given their primary keys.
    ///
    ///     let persons = try Person.fetchAll(db, keys: [1, 2, 3]) // [Person]
    ///
    /// The order of records in the returned array is undefined.
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - keys: A sequence of primary keys.
    /// - returns: An array of records.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchAll<Sequence: Swift.Sequence>(_ db: Database, keys: Sequence) throws -> [Self] where Sequence.Iterator.Element: DatabaseValueConvertible {
        let keys = Array(keys)
        if keys.isEmpty {
            // Avoid hitting the database
            return []
        }
        return try filter(db, keys: keys).fetchAll(db)
    }
    
    /// Returns a single record given its primary key.
    ///
    ///     let person = try Person.fetchOne(db, key: 123) // Person?
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - key: A primary key value.
    /// - returns: An optional record.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchOne<PrimaryKeyType: DatabaseValueConvertible>(_ db: Database, key: PrimaryKeyType?) throws -> Self? {
        guard let key = key else {
            // Avoid hitting the database
            return nil
        }
        return try filter(db, keys: [key]).fetchOne(db)
    }
}

extension RowConvertible where Self: TableMapping {
    
    // MARK: Fetching by Key
    
    // TODO GRDB 2.0: make the result non optional
    /// Returns a cursor over records identified by the provided unique keys
    /// (primary key or any key with a unique index on it).
    ///
    ///     let persons = try Person.fetchCursor(db, keys: [["email": "a@example.com"], ["email": "b@example.com"]]) // DatabaseCursor<Person>
    ///     while let person = try persons.next() { // Person
    ///         ...
    ///     }
    ///
    /// Records are iterated in unspecified order.
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - keys: An array of key dictionaries.
    /// - returns: A cursor over fetched records.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchCursor(_ db: Database, keys: [[String: DatabaseValueConvertible?]]) throws -> DatabaseCursor<Self>? {
        return try filter(db, keys: keys).fetchCursor(db)
    }
    
    /// Returns an array of records identified by the provided unique keys
    /// (primary key or any key with a unique index on it).
    ///
    ///     let persons = try Person.fetchAll(db, keys: [["email": "a@example.com"], ["email": "b@example.com"]]) // [Person]
    ///
    /// The order of records in the returned array is undefined.
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - keys: An array of key dictionaries.
    /// - returns: An array of records.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchAll(_ db: Database, keys: [[String: DatabaseValueConvertible?]]) throws -> [Self] {
        let keys = Array(keys)
        if keys.isEmpty {
            // Avoid hitting the database
            return []
        }
        return try filter(db, keys: keys).fetchAll(db)
    }
    
    /// Returns a single record identified by a unique key (the primary key or
    /// any key with a unique index on it).
    ///
    ///     let person = try Person.fetchOne(db, key: ["name": Arthur"]) // Person?
    ///
    /// - parameters:
    ///     - db: A database connection.
    ///     - key: A dictionary of values.
    /// - returns: An optional record.
    /// - throws: A DatabaseError is thrown whenever an SQLite error occurs.
    public static func fetchOne(_ db: Database, key: [String: DatabaseValueConvertible?]) throws -> Self? {
        return try filter(db, keys: [key]).fetchOne(db)
    }
}
