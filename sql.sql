CREATE SEQUENCE employee_code_seq
  AS BIGINT
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCYCLE;
  
CREATE FUNCTION generateNewEmployeeCode(@nextSeqValInt bigint)
RETURNS Char(8)
AS
    BEGIN       
        declare @codeEmp  char(8)
        declare @nextSeqValString varchar(5) = CAST(@nextSeqValInt as varchar(5))        
        declare @firstLetter char(3) = 'EMP';
 
        SET @codeEmp = CASE
            WHEN  @nextSeqValInt > 0 and @nextSeqValInt < 10 THEN @firstLetter+'0000'+@nextSeqValString
            WHEN  @nextSeqValInt >= 10 and @nextSeqValInt < 100 THEN @firstLetter+'000'+@nextSeqValString
            WHEN  @nextSeqValInt >= 100 and @nextSeqValInt < 1000 THEN @firstLetter+'00'+@nextSeqValString
            WHEN  @nextSeqValInt >= 1000 and @nextSeqValInt < 10000 THEN @firstLetter+'0'+@nextSeqValString
        END       
    RETURN @codeEmp
    END
    
    SELECT dbo.generateNewEmployeeCode(CAST(NEXT VALUE FOR dbo.employee_code_seq as bigint));
