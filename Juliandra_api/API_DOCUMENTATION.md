# API Documentation - Juliandra 5G

## Base URL
```
http://localhost:8000/api
```

---

## Agenda API

### 1. Get All Agenda
**Endpoint:** `GET /agenda`

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "judul": "Rapat Koordinasi Tim",
      "keterangan": "Membahas progress project 5G",
      "is_done": false,
      "created_at": "2026-01-20T10:00:00.000000Z",
      "updated_at": "2026-01-20T10:00:00.000000Z"
    }
  ]
}
```

---

### 2. Create Agenda
**Endpoint:** `POST /agenda`

**Request Body:**
```json
{
  "judul": "Meeting dengan Client",
  "keterangan": "Presentasi sistem Juliandra 5G",
  "is_done": false
}
```

**Response (201 Created):**
```json
{
  "id": 2,
  "judul": "Meeting dengan Client",
  "keterangan": "Presentasi sistem Juliandra 5G",
  "is_done": false,
  "created_at": "2026-01-20T11:00:00.000000Z",
  "updated_at": "2026-01-20T11:00:00.000000Z"
}
```

---

### 3. Get Single Agenda
**Endpoint:** `GET /agenda/{id}`

**Response (200 OK):**
```json
{
  "id": 1,
  "judul": "Rapat Koordinasi Tim",
  "keterangan": "Membahas progress project 5G",
  "is_done": false,
  "created_at": "2026-01-20T10:00:00.000000Z",
  "updated_at": "2026-01-20T10:00:00.000000Z"
}
```

**Response (404 Not Found):**
```json
{
  "message": "Agenda not found"
}
```

---

### 4. Update Agenda
**Endpoint:** `PUT /agenda/{id}`

**Request Body:**
```json
{
  "judul": "Rapat Koordinasi Tim (Updated)",
  "is_done": true
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "judul": "Rapat Koordinasi Tim (Updated)",
  "keterangan": "Membahas progress project 5G",
  "is_done": true,
  "created_at": "2026-01-20T10:00:00.000000Z",
  "updated_at": "2026-01-20T12:00:00.000000Z"
}
```

---

### 5. Delete Agenda
**Endpoint:** `DELETE /agenda/{id}`

**Response (200 OK):**
```json
{
  "message": "Agenda deleted"
}
```

---

## Database Structure

### Table: agenda

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary Key, Auto Increment |
| judul | varchar(255) | Agenda title |
| keterangan | text | Agenda description |
| is_done | tinyint(1) | 0 = Not Done, 1 = Done |
| created_at | timestamp | Creation timestamp |
| updated_at | timestamp | Last update timestamp |

---

## Error Responses

### 400 Bad Request
```json
{
  "message": "The given data was invalid.",
  "errors": {
    "judul": ["The judul field is required."]
  }
}
```

### 404 Not Found
```json
{
  "message": "Agenda not found"
}
```

---

## How to Run

1. Install dependencies:
```bash
composer install
```

2. Copy environment file:
```bash
cp .env.example .env
```

3. Generate key:
```bash
php artisan key:generate
```

4. Run migration:
```bash
php artisan migrate:fresh
```

5. Seed sample data:
```bash
php artisan db:seed
```

6. Start server:
```bash
php artisan serve
```

---

## API Testing with cURL

### Get All Agenda
```bash
curl http://localhost:8000/api/agenda
```

### Create Agenda
```bash
curl -X POST http://localhost:8000/api/agenda \
  -H "Content-Type: application/json" \
  -d '{"judul":"Tes Agenda","keterangan":"Deskripsi tes","is_done":false}'
```

### Get Agenda by ID
```bash
curl http://localhost:8000/api/agenda/1
```

### Update Agenda
```bash
curl -X PUT http://localhost:8000/api/agenda/1 \
  -H "Content-Type: application/json" \
  -d '{"judul":"Updated Agenda","is_done":true}'
```

### Delete Agenda
```bash
curl -X DELETE http://localhost:8000/api/agenda/1
```

