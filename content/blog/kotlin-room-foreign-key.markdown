---
title: "Understanding Kotlin Room Foreign Keys"
description: "
In modern Android development, the Room Persistence Library has become a cornerstone for handling local database operations in a more efficient and type - safe manner. One of the powerful features that Room offers is the support for foreign keys. A foreign key is a field (or collection of fields) in one table that refers to the primary key of another table. This relationship helps in maintaining data integrity and establishing connections between different entities in the database.  Foreign keys are crucial when dealing with related data. For example, in an e - commerce application, you might have a `Product` table and an `Order` table. Each order contains one or more products, and you can use a foreign key in the `Order` table to reference the `Product` table, ensuring that each order is associated with valid products.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts of Foreign Keys in Kotlin Room
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of Foreign Keys in Kotlin Room
### What is a Foreign Key?
A foreign key is a column or a set of columns in a table that refers to the primary key of another table. In the context of Kotlin Room, when you define a foreign key, you are essentially creating a link between two entities in your database.

### ON DELETE and ON UPDATE Actions
When a record in the parent table (the table with the primary key) is deleted or updated, Room allows you to define actions for the child table (the table with the foreign key). There are several actions available:
- **CASCADE**: If a record in the parent table is deleted or updated, the corresponding records in the child table are also deleted or updated.
- **SET NULL**: If a record in the parent table is deleted or updated, the foreign key values in the child table are set to `NULL`.
- **SET DEFAULT**: If a record in the parent table is deleted or updated, the foreign key values in the child table are set to their default values.
- **RESTRICT**: Prevents the deletion or update of a record in the parent table if there are corresponding records in the child table.

## Typical Usage Scenarios
### One - to - One Relationship
A one - to - one relationship exists when each record in one table is associated with exactly one record in another table. For example, in a user profile application, each user might have exactly one profile picture. You can use a foreign key in the `ProfilePicture` table to reference the `User` table.

### One - to - Many Relationship
A one - to - many relationship is the most common scenario. For instance, in a note - taking app, each user can have multiple notes. The `Note` table can have a foreign key referencing the `User` table, indicating which user created each note.

### Many - to - Many Relationship
In a many - to - many relationship, multiple records in one table can be associated with multiple records in another table. To implement this in Room, you usually need an intermediate table with two foreign keys, each referencing one of the main tables. For example, in a music app, a song can be part of multiple playlists, and a playlist can contain multiple songs. You can create a `SongPlaylistJoin` table with foreign keys to the `Song` and `Playlist` tables.

## Code Examples

### One - to - Many Relationship Example
```kotlin
import androidx.room.*

// Parent entity
@Entity(tableName = "user")
data class User(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val name: String
)

// Child entity
@Entity(
    tableName = "note",
    foreignKeys = [ForeignKey(
        entity = User::class,
        parentColumns = ["id"],
        childColumns = ["userId"],
        onDelete = ForeignKey.CASCADE
    )]
)
data class Note(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val content: String,
    val userId: Int
)

// DAO for User
@Dao
interface UserDao {
    @Insert
    suspend fun insertUser(user: User): Long
}

// DAO for Note
@Dao
interface NoteDao {
    @Insert
    suspend fun insertNote(note: Note): Long
}

// Database
@Database(entities = [User::class, Note::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun noteDao(): NoteDao
}
```
In this example, the `Note` table has a foreign key `userId` that references the `id` column in the `User` table. If a user is deleted, the `CASCADE` action ensures that all the notes associated with that user are also deleted.

### Many - to - Many Relationship Example
```kotlin
import androidx.room.*

// First entity
@Entity(tableName = "song")
data class Song(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val title: String
)

// Second entity
@Entity(tableName = "playlist")
data class Playlist(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val name: String
)

// Intermediate entity
@Entity(
    tableName = "song_playlist_join",
    primaryKeys = ["songId", "playlistId"],
    foreignKeys = [
        ForeignKey(
            entity = Song::class,
            parentColumns = ["id"],
            childColumns = ["songId"],
            onDelete = ForeignKey.CASCADE
        ),
        ForeignKey(
            entity = Playlist::class,
            parentColumns = ["id"],
            childColumns = ["playlistId"],
            onDelete = ForeignKey.CASCADE
        )
    ]
)
data class SongPlaylistJoin(
    val songId: Int,
    val playlistId: Int
)

// DAO for Song
@Dao
interface SongDao {
    @Insert
    suspend fun insertSong(song: Song): Long
}

// DAO for Playlist
@Dao
interface PlaylistDao {
    @Insert
    suspend fun insertPlaylist(playlist: Playlist): Long
}

// DAO for SongPlaylistJoin
@Dao
interface SongPlaylistJoinDao {
    @Insert
    suspend fun insertJoin(join: SongPlaylistJoin): Long
}

// Database
@Database(entities = [Song::class, Playlist::class, SongPlaylistJoin::class], version = 1)
abstract class MusicDatabase : RoomDatabase() {
    abstract fun songDao(): SongDao
    abstract fun playlistDao(): PlaylistDao
    abstract fun songPlaylistJoinDao(): SongPlaylistJoinDao
}
```
In this many - to - many example, the `SongPlaylistJoin` table has two foreign keys, one for the `Song` table and one for the `Playlist` table.

## Best Practices
- **Use Appropriate ON DELETE and ON UPDATE Actions**: Choose the action that best suits your application's data integrity requirements. For example, if you want to ensure that related data is always consistent, use `CASCADE` for deletes and updates.
- **Index Foreign Keys**: Indexing foreign keys can improve the performance of queries that involve joins between tables. You can use the `@Index` annotation in Room to create an index on a foreign key column.
```kotlin
@Entity(
    tableName = "note",
    foreignKeys = [ForeignKey(
        entity = User::class,
        parentColumns = ["id"],
        childColumns = ["userId"],
        onDelete = ForeignKey.CASCADE
    )],
    indices = [Index(value = ["userId"])]
)
data class Note(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val content: String,
    val userId: Int
)
```
- **Keep Your Database Schema Simple**: Avoid over - complicating your database schema with too many foreign key relationships. Only use foreign keys when they are necessary to maintain data integrity.

## Conclusion
Kotlin Room foreign keys are a powerful tool for managing relationships between entities in your Android application's local database. By understanding the core concepts, typical usage scenarios, and best practices, you can design a more robust and efficient database schema. Whether you are dealing with one - to - one, one - to - many, or many - to - many relationships, Room's support for foreign keys simplifies the process of maintaining data integrity and performing complex queries.

## References
- [Android Developers - Room Persistence Library](https://developer.android.com/training/data-storage/room)
- [SQLite Foreign Key Support](https://sqlite.org/foreignkeys.html)