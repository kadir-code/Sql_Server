
--Fill facton helps prevent index fragmentation.
CREATE NONCLUSTERED INDEX [IX_Person_FirstName]
ON [Person].[Person]([FirstName])
INCLUDE ( [PersonType], [LastName]) WITH (FILLFACTOR = 80)

--When creating a new index, a fill factor can be added for possible new records, or the default fill factor can be given for all new db from the database settings option in the server properties.