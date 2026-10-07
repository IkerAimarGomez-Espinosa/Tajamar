 BEGIN TRANSACTION;
 UPDATE dbo.OrderHistory SET Status = N'Cancelled' WHERE OrderID = 1;
 -- Simulating an application that stopped without committing
  ROLLBACK TRANSACTION;