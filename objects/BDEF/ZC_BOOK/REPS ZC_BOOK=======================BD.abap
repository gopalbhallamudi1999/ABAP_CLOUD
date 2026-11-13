projection;
strict ( 2 );

define behavior for ZC_BOOK alias Book
use etag
{
  use create;
  use update;
  use delete;

  use action markAvailable;
  use action markBorrowed;
}