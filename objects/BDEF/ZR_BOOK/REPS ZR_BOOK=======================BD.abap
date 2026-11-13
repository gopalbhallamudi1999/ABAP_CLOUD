managed implementation in class zbp_r_book unique;
strict ( 2 );

define behavior for ZR_BOOK alias Book
persistent table zbook_a
lock master
authorization master ( global )
etag master LocalLastChangedAt
{
  create;
  update;
  delete;

  field ( numbering : managed, readonly ) BookUUID;
  field ( readonly ) BookID, Status, StatusCriticality,
  LocalCreatedBy, LocalCreatedAt,
  LocalLastChangedBy, LocalLastChangedAt, LastChangedAt;
  field ( mandatory ) Title, Author;

  action ( features : instance ) markAvailable result [1] $self;
  action ( features : instance ) markBorrowed result [1] $self;

  determination setInitialValues on modify { create; }
  validation validatePrice on save { create; field Price, CurrencyCode; }

  mapping for zbook_a
    {
      BookUUID           = book_uuid;
      BookID             = book_id;
      Title              = title;
      Author             = author;
      Genre              = genre;
      Price              = price;
      CurrencyCode       = currency_code;
      Status             = status;
      LocalCreatedBy     = local_created_by;
      LocalCreatedAt     = local_created_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
      LastChangedAt      = last_changed_at;
    }
}