<script>
  import { active, editDesc } from '../../UrbitStore'

</script>

<div class="section">
  <div class="title">Title</div>
  <div class="arg">
    <textarea
      bind:value={$active[0].description}
      on:blur={editDesc({id: $active[0].id, description: $active[0].description})}
    />
  </div>
</div>


<style>

  textarea {
    width: 100%;
    height: 16em;
    padding: 1em;
    box-sizing: border-box;
    border-radius: 4px;
    border: none;
    background-color: #e9e9e9;
    resize: none;  
  }

  textarea:focus {
    outline: none;
  }

  .section {
    margin: 2em 0 2em .6em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .arg {
    margin-top: 1em;
    font-size: .8em;
  }

</style>
