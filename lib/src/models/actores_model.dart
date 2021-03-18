
class Actores {
    
    List<Actor> listActores = [];
    Actores.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return ;
      jsonList.forEach((actorJson) => listActores.add(Actor.fromJson(actorJson)));
    } 

}

class Actor {
    Actor({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String profilePath;
    int castId;
    String character;
    String creditId;
    int order;
    String department;
    String job;

    Actor.fromJson(Map<String,dynamic> json){
      adult               = json['adult'];
      gender              = json['gender'];
      id                  = json['id'];
      knownForDepartment  = json['known_for_department'];
      name                = json['name'];
      originalName        = json['original_name'];
      popularity          = json['popularity'] / 1;
      profilePath         = json['profile_path'];
      castId              = json['cast_id'];
      character           = json['character'];
      creditId            = json['credit_id'];
      order               = json['order'];
      department          = json['department'];
      job                 = json['job'];
    }

    String getUrlImg(){
      if( profilePath == null) return 'https://i.stack.imgur.com/y9DpT.jpg';
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
}
