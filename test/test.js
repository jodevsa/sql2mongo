
var sqltomongo = require('../sqltomongo.js').parse
function generateQuery(table,condition={},columns={}){

let empty={"collection":table,"condition":condition,"columns":columns}
return empty;
}
var assert = require('assert');
  describe('from table', function() {
      it('should return a JSON with collection objects"', function() {
        assert.deepEqual(generateQuery("objects"),sqltomongo("select * from objects"));
      })

});
describe('where', function() {
    describe('euqal operator', function() {
      it('should return a collection with equal operator INTEGER"', function() {
        assert.deepEqual(generateQuery("objects",{id:1}),sqltomongo(
          "select * from objects where id=1"));
      })
      it('should return a collection with equal operator BOOLEAN "', function() {
        assert.deepEqual(generateQuery("objects",{object:true}),sqltomongo(
          "select * from objects where object=true"));
      })
      it('should return a collection with equal operator STRING "', function() {
        assert.deepEqual(generateQuery("objects",{object:"large"}),sqltomongo(
          'select * from objects where object="large"'));
      })
      it('should return a collection with equal operator FLOAT "', function() {
        assert.deepEqual(generateQuery("objects",{number:4.5}),sqltomongo(
          'select * from objects where number=4.5'));
      })

    });
    describe('greater than operator', function() {
      it('should return a collection with equal operator INTEGER"', function() {
        assert.deepEqual(generateQuery("objects",{id:{"$gt":1433}}),sqltomongo(
          "select * from objects where id>1433"));
      })
      it('should return a collection with equal operator FLOAT"', function() {
        assert.deepEqual(generateQuery("objects",{id:{"$gt":980.5}}),sqltomongo(
          "select * from objects where id>980.5"));
      })

    });
    describe('lower than operator', function() {
      it('should return a collection with equal operator INTEGER"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$lt":832}}),sqltomongo(
          "select * from objects where height<832"));
      })
      it('should return a collection with equal operator FLOAT"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$lt":493.494}}),sqltomongo(
          "select * from objects where height<493.494"));
      })

    });
    describe('greater than or equal operator', function() {
      it('should return a collection with equal operator INTEGER"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$gte":0}}),sqltomongo(
          "select * from objects where height>=0"));
      })
      it('should return a collection with equal operator FLOAT"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$gte":43.0}}),sqltomongo(
          "select * from objects where height>=43.0"));
      })

    });
    describe('lower than or equal operator', function() {
      it('should return a collection with equal operator INTEGER"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$lte":832}}),sqltomongo(
          "select * from objects where height<=832"));
      })
      it('should return a collection with equal operator FLOAT"', function() {
        assert.deepEqual(generateQuery("objects",{height:{"$lte":493.494}}),sqltomongo(
          "select * from objects where height<=493.494"));
      })

    });

  });
