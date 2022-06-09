<script>
  export let title;
  export let description;
  export let author;
  export let slug;

</script>

<div class="names">
  <div class=title>{title}</div>
  <div class="description">{description}</div>
  <div class="contact">~{author}/{slug}</div>
</div>

<style>

  .names {
    text-align: center;
    margin-bottom: .6em;
    padding: .6em 0 1.3em 0;
    border-bottom: 2px solid black;
  }

  .contact {
    font-size: 0.8em;
  }

  .title {
    font-size: 2.6em; 
  }

  .description {
    font-size: 1em;
    margin-bottom: 1em;
  }

</style>

