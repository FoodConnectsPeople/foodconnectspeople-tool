include "head.iol"

main {

        language = "italian";
        t.verbose = true;

      /******************** Section 3: test of grocerylist *********/

      undef(t);
      undef(response);

      t.convert_all = true;
      t.verbose     = false;
      t.language    = language;
      t.rec_persons[0].recipe_id = 96;
      t.rec_persons[0].persons   = 4;
      t.rec_persons[1].recipe_id = 97;
      t.rec_persons[1].persons   = 6;
      t.rec_persons[2].recipe_id = 98;
      t.rec_persons[2].persons   = 6;
      t.rec_persons[3].recipe_id = 99;
      t.rec_persons[3].persons   = 6;
      t.rec_persons[4].recipe_id = 100;
      t.rec_persons[4].persons   = 2;
      t.rec_persons[5].recipe_id = 101;
      t.rec_persons[5].persons   = 2;
      t.rec_persons[6].recipe_id = 102;
      t.rec_persons[6].persons   = 2;
      t.rec_persons[7].recipe_id = 103;
      t.rec_persons[7].persons   = 2;
      t.rec_persons[8].recipe_id = 104;
      t.rec_persons[8].persons   = 4;
      t.rec_persons[0].recipe_id = 105;
      t.rec_persons[0].persons   = 4;
      t.rec_persons[1].recipe_id = 106;
      t.rec_persons[1].persons   = 6;
      t.rec_persons[2].recipe_id = 107;
      t.rec_persons[2].persons   = 6;
      t.rec_persons[3].recipe_id = 108;
      t.rec_persons[3].persons   = 6;
      t.rec_persons[4].recipe_id = 109;
      t.rec_persons[4].persons   = 2;
      t.rec_persons[5].recipe_id = 110;
      t.rec_persons[5].persons   = 2;
      t.rec_persons[6].recipe_id = 111;
      t.rec_persons[6].persons   = 2;


      buildGroceryList@DbService(t)(response);

      println@Console("   ")();
      println@Console(" ======== Test of GroceryList =============")();
      for (l = 0, l < #response.classes, l++) {
        println@Console ("Class of ingredients: " + response.classes[l].class)();
        for (m = 0, m < #response.classes[l].ingredients, m++) {
          println@Console (" Ingredient : " + response.classes[l].ingredients[m].ingredient + " : " +
                                              response.classes[l].ingredients[m].quantity + " " +
                                              response.classes[l].ingredients[m].unit_of_measure) ()
        }
      }


}
