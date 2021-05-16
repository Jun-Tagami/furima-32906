const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  Payjp.setPublicKey("pk_test_23956e53561307ca7b505df6"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault(); //←ここでrailsの処理をストップさせている。これで「createに行かないで7行目以降のトークンが行われたら処理を開始してください」の意味
   
    const formResult = document.getElementById("charge-form"); //3行目と同じだが、ここで入力した情報を取り込んでいる。
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_address[number]"),
      cvc: formData.get("order_address[cvc]"),
      exp_month: formData.get("order_address[month]"),
      exp_year: `20${formData.get("order_address[year]")}`,
    };
    Payjp.createToken(card, (status, response) => {
      if (status == 200) { //ステータスコード200は正常の意味 正常だったら以下のコードを読み込む
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj); //beforeendという位置がある（html）tokenObj（関数）を埋め込む 　insertAdjacentHTM= htmlを挿入するメソッド　第一引数が位置、第二引数が何を入れるか  tokenオブジェクトを挿入する。
      }
       document.getElementById("card-number").removeAttribute("name");
       document.getElementById("card-cvc").removeAttribute("name");
       document.getElementById("card-exp-month").removeAttribute("name");
       document.getElementById("card-exp-year").removeAttribute("name");

       document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);